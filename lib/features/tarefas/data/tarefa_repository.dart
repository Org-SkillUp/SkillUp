import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';

/// Repositório em memória das tarefas.
///
/// Como o app ainda não possui backend, guardamos as tarefas em uma lista
/// que vive apenas durante a sessão (some ao fechar o app). É um *singleton*
/// — uma instância única compartilhada — para que TODAS as telas leiam e
/// gravem na mesma lista. Assim, ao criar/editar em uma tela, a outra
/// enxerga a mudança.
class TarefaRepository {
  // Construtor privado: ninguém de fora consegue criar outra instância.
  TarefaRepository._();

  /// Instância única usada por todo o app.
  static final TarefaRepository instance = TarefaRepository._();

  // Lista inicial com dados de exemplo (inclui o mock da tela de detalhe).
  final List<TarefaDetail> _tarefas = [
    TarefaDetail.mock,
    const TarefaDetail(
      id: 'seed-canais-vendas',
      titulo: 'Estudar Canais de Vendas',
      trilhaNome: 'Administração de Empresas',
      dataInicio: '10 de março de 2026',
      dataPrazo: '14 de março de 2026',
      metaRelacionada: 'Prova gestão de vendas',
      descricao:
          'Revisar os principais canais de vendas e seus indicadores de '
          'desempenho antes da prova.',
    ),
  ];

  // Contador simples para gerar ids únicos das novas tarefas.
  int _proximoId = 1;

  /// Lista de tarefas em modo somente leitura, evitando que outras camadas
  /// alterem a lista interna por engano (encapsulamento).
  List<TarefaDetail> get tarefas => List.unmodifiable(_tarefas);

  /// Adiciona uma nova tarefa gerando um id único e a devolve já com o id.
  ///
  /// O id que vier na [tarefa] é ignorado de propósito: quem decide a
  /// identidade de uma tarefa nova é a camada de dados.
  TarefaDetail adicionar(TarefaDetail tarefa) {
    final nova = tarefa.copyWith(id: _gerarId());
    _tarefas.add(nova);
    return nova;
  }

  /// Atualiza uma tarefa existente, localizada pelo [id]. Se não encontrar
  /// (id inexistente), nada acontece.
  void atualizar(TarefaDetail tarefa) {
    final indice = _tarefas.indexWhere((t) => t.id == tarefa.id);
    if (indice == -1) return;
    _tarefas[indice] = tarefa;
  }

  /// Remove a tarefa identificada por [id]. Se o id não existir, nada
  /// acontece (operação segura, sem erro).
  void remover(String id) {
    _tarefas.removeWhere((t) => t.id == id);
  }

  String _gerarId() => 'tarefa-${_proximoId++}';
}
