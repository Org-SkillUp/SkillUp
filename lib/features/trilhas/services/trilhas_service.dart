import 'package:SkillUp/core/services/firestore_service.dart';
import 'package:SkillUp/features/tarefas/models/list.dart';
import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';
import 'package:SkillUp/features/trilhas/models/trilha.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class TrilhasService extends FirestoreService<Trilha> {
  TrilhasService() : super(
    collection: 'trilhas',
    fromMap: Trilha.fromMap,
  );

  final Map<String, String> _titlesCache = {};

  Stream<List<Trilha>> readListByUser(String email) {
    final trilhasStream = firestore
      .collection(collection)
      .where('createdBy', isEqualTo: email)
      .snapshots()
      .map((s) {
        final trilhas = s.docs.map((d) => fromMap(d.data(), d.id)).toList();
        for (final t in trilhas) {
          if (t.id != null) _titlesCache[t.id!] = t.title;
        }
        return trilhas;
      });

    final tarefasStream = firestore
      .collection('tarefas')
      .where('createdBy', isEqualTo: email)
      .snapshots()
      .map((s) => s.docs.map((d) => TarefaDetail.fromMap(d.data(), d.id)).toList());

    return Rx.combineLatest2(
      trilhasStream,
      tarefasStream,
      (List<Trilha> trilhas, List<TarefaDetail> tarefas) =>
        _merge(trilhas, tarefas),
    );
  }

  List<Trilha> _merge(List<Trilha> trilhas, List<TarefaDetail> tarefas) {
    final Map<String, Map<String, List<TarefaDetail>>> grouped = {};
    final Map<String, String> metaLabels = {};

    for (final tarefa in tarefas) {
      final trilhaId = tarefa.trilhaId;
      final metaNorm = (tarefa.metaRelacionada ?? '').toUpperCase();
      final metaLabel = tarefa.metaRelacionada ?? '';

      metaLabels[metaNorm] = metaLabel;

      grouped
          .putIfAbsent(trilhaId, () => {})
          .putIfAbsent(metaNorm, () => [])
          .add(tarefa);
    }

    return trilhas.map((trilha) {
      final byMeta = grouped[trilha.id] ?? {};

      final classifiedLists = byMeta.entries.map((entry) {
        return ClassifiedList(
          classifier: metaLabels[entry.key]?.toUpperCase() ?? entry.key,
          items: entry.value,
        );
      }).toList();

      return trilha.copyWith(tarefas: classifiedLists);
    }).toList();
  }

  Future<void> createTarefa(TarefaDetail tarefa) async {
    await firestore.collection('tarefas').add({
      ...tarefa.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
      'createdBy': FirebaseAuth.instance.currentUser?.email ?? 'unknown',
    });
  }

  Future<void> updateTarefa(String id, Map<String, dynamic> fields) async {
    await firestore.collection('tarefas').doc(id).update(fields);
  }

  Future<void> updateStatus(String id, TrilhaStatus status) async {
    await firestore.collection(collection).doc(id).update({
      'status': status.name,
      'updatedBy': FirebaseAuth.instance.currentUser?.email ?? 'unknown',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateDateField(String id, String fieldName, DateTime date) async {
    await firestore.collection(collection).doc(id).update({
      fieldName: Timestamp.fromDate(date),
      'updatedBy': FirebaseAuth.instance.currentUser?.email ?? 'unknown',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateByMap(String id, Map<String, Object?> map) async {
    await firestore.collection(collection).doc(id).update({
      ...map,
      'updatedBy': FirebaseAuth.instance.currentUser?.email ?? 'unknown',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> delete(String id) async {
  final tarefasSnapshot = await firestore
      .collection('tarefas')
      .where('trilhaId', isEqualTo: id)
      .get();

    for (final doc in tarefasSnapshot.docs) {
      await doc.reference.delete();
    }

    await firestore.collection(collection).doc(id).delete();
  }
}