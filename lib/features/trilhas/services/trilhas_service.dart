import 'package:SkillUp/core/services/firestore_service.dart';
import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';
import 'package:SkillUp/features/trilhas/models/list.dart';
import 'package:SkillUp/features/trilhas/models/trilha.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

// TODO: atualizar registro do usuário

class TrilhasService extends FirestoreService<Trilha> {
  TrilhasService() : super(
    collection: 'trilhas',
    fromMap: Trilha.fromMap,
  );

  // TODO: mover para service de tarefa
  Future<void> createTarefa(TarefaDetail tarefa) async {
    await firestore.collection('tarefas').add({
      ...tarefa.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
      'createdBy': FirebaseAuth.instance.currentUser?.email,
    });
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
      fieldName: date,
      'updatedBy': FirebaseAuth.instance.currentUser?.email ?? 'unknown',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Trilha>> readListByUser(String email) {
    final trilhasStream = firestore
      .collection(collection)
      .where('createdBy', isEqualTo: email)
      .snapshots()
      .map((s) => s.docs.map((d) => fromMap(d.data(), d.id)).toList());

    return trilhasStream.switchMap((trilhas) {
      if (trilhas.isEmpty) return Stream.value([]);

      final enrichedStreams = trilhas.map((trilha) {
        return firestore
          .collection('tarefas')
          .where('trilhaId', isEqualTo: trilha.id)
          .snapshots()
          .map((snap) {
            final tarefas = snap.docs
              .map((d) => TarefaDetail.fromMap(d.data(), d.id))
              .toList();

            final Map<String?, List<TarefaDetail>> grouped = {};
            for (final tarefa in tarefas) {
              grouped.putIfAbsent(tarefa.metaRelacionada, () => []).add(tarefa);
            }

            final classifiedLists = grouped.entries.map((entry) {
              return ClassifiedList(
                classifier: entry.key,
                items: entry.value,
              );
            }).toList();

            return trilha.copyWith(tarefas: classifiedLists);
          });
      });

      return Rx.combineLatestList(enrichedStreams);
    });
  }
}