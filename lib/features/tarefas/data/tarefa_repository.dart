import 'package:SkillUp/core/services/firestore_service.dart';
import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';

/// Repositório das tarefas ligado ao Firestore via [FirestoreService].
///
/// Na criação e na atualização, os metadados de [PersistenceModel]
/// (`createdBy`, `createdAt`, `updatedAt`, `updatedBy`) são gravados
/// automaticamente pelo serviço, junto com os campos da tarefa.
class TarefaRepository {
  TarefaRepository._();

  static final TarefaRepository instance = TarefaRepository._();

  final FirestoreService<TarefaDetail> _service = FirestoreService<TarefaDetail>(
    collection: 'tarefas',
    fromMap: TarefaDetail.fromMap,
  );

  Stream<List<TarefaDetail>> observarTarefas() => _service.readList();

  Future<void> adicionar(TarefaDetail tarefa) => _service.create(tarefa);

  Future<void> atualizar(TarefaDetail tarefa) async {
    final id = tarefa.id;
    if (id == null || id.isEmpty) {
      throw StateError('Não é possível atualizar tarefa sem id.');
    }
    await _service.update(id, tarefa);
  }

  Future<void> remover(String id) => _service.delete(id);
}
