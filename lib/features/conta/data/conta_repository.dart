import 'package:SkillUp/features/conta/models/conta_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContaRepository {
  ContaRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<ContaModel> fetchContaData(String userId) async {
    final trilhasDocs = await _getDocsWithUserFallback('trilhas', userId);
    final tarefasDocs = await _getDocsWithUserFallback('tarefas', userId);

    final trilhasAtivas = trilhasDocs
        .where((doc) => doc.data()['status'] == 'active')
        .length;
    final tarefas = tarefasDocs
        .map((doc) => ContaTarefaModel.fromMap(doc.data()))
        .toList();

    return ContaModel(trilhasAtivas: trilhasAtivas, tarefas: tarefas);
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
  _getDocsWithUserFallback(String collection, String userId) async {
    final userSnapshot = await _firestore
        .collection(collection)
        .where('createdBy', isEqualTo: userId)
        .get();

    if (userSnapshot.docs.isNotEmpty) return userSnapshot.docs;

    final fallbackSnapshot = await _firestore.collection(collection).get();
    return fallbackSnapshot.docs;
  }
}
