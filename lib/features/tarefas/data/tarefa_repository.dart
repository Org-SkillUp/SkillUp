import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Repositório das tarefas, agora ligado ao Cloud Firestore.
///
/// É o ÚNICO ponto que conversa com o banco (clean architecture): as telas
/// falam com o repositório, e o repositório fala com o Firestore. Assim, se
/// um dia trocarmos o banco, só este arquivo muda.
///
/// Os dados ficam na coleção `tarefas`. O id de cada [TarefaDetail] é o id
/// do documento no Firestore, o que permite atualizar/remover com precisão.
class TarefaRepository {
  // Construtor privado: ninguém de fora cria outra instância.
  TarefaRepository._();

  /// Instância única usada por todo o app.
  static final TarefaRepository instance = TarefaRepository._();

  // Referência à coleção de tarefas no Firestore.
  final CollectionReference<Map<String, dynamic>> _colecao =
      FirebaseFirestore.instance.collection('tarefas');

  /// Observa a lista de tarefas em tempo real.
  ///
  /// Retorna um [Stream]: sempre que algo muda no banco (criar/editar/excluir,
  /// inclusive de outro dispositivo), a tela que escuta este stream é
  /// reconstruída automaticamente com os dados atualizados.
  Stream<List<TarefaDetail>> observarTarefas() {
    return _colecao.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => TarefaDetail.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  /// Cria uma nova tarefa. O Firestore gera o id do documento
  /// automaticamente (por isso o id que vier na [tarefa] é ignorado).
  Future<void> adicionar(TarefaDetail tarefa) async {
    await _colecao.add(tarefa.toMap());
  }

  /// Atualiza a tarefa existente cujo id de documento é [TarefaDetail.id].
  Future<void> atualizar(TarefaDetail tarefa) async {
    await _colecao.doc(tarefa.id).update(tarefa.toMap());
  }

  /// Remove a tarefa identificada por [id] (id do documento).
  Future<void> remover(String id) async {
    await _colecao.doc(id).delete();
  }
}
