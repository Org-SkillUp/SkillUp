/// Dados exibidos na tela de detalhe de uma tarefa.
class TarefaDetail {
  const TarefaDetail({
    required this.titulo,
    required this.trilhaNome,
    required this.dataInicio,
    required this.dataPrazo,
    required this.metaRelacionada,
    required this.descricao,
  });

  final String titulo;
  final String trilhaNome;
  final String dataInicio;
  final String dataPrazo;
  final String metaRelacionada;
  final String descricao;

  /// Dados mock para desenvolvimento e testes da tela de detalhe.
  static const mock = TarefaDetail(
    titulo: 'Estudar Fluxo de Caixa',
    trilhaNome: 'Administração de Empresas',
    dataInicio: '18 de abril de 2026',
    dataPrazo: '20 de abril de 2026',
    metaRelacionada: 'Prova administração financeira',
    descricao:
        'Leitura do material didático sobre gestão de tesouraria e resolução '
        'dos 5 exercícios práticos de projeção financeira da Unidade 2. '
        'Prazo final para envio do relatório de progresso: 20/04/2026.',
  );
}
