/// Dados exibidos na tela de detalhe de uma tarefa.
class TarefaDetail {
  const TarefaDetail({
    required this.id,
    required this.titulo,
    required this.trilhaNome,
    required this.dataInicio,
    required this.dataPrazo,
    required this.metaRelacionada,
    required this.descricao,
  });

  /// Identidade da tarefa. É o que permite localizar e atualizar uma tarefa
  /// já existente no repositório. Tarefas novas recebem um id gerado na
  /// camada de dados (ver `TarefaRepository`).
  final String id;

  final String titulo;
  final String trilhaNome;
  final String dataInicio;
  final String dataPrazo;
  final String metaRelacionada;
  final String descricao;

  /// Cria uma cópia da tarefa alterando apenas os campos informados.
  ///
  /// Mantém o modelo imutável: na edição geramos uma nova instância
  /// preservando o `id` original, em vez de mudar os campos no lugar.
  TarefaDetail copyWith({
    String? id,
    String? titulo,
    String? trilhaNome,
    String? dataInicio,
    String? dataPrazo,
    String? metaRelacionada,
    String? descricao,
  }) {
    return TarefaDetail(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      trilhaNome: trilhaNome ?? this.trilhaNome,
      dataInicio: dataInicio ?? this.dataInicio,
      dataPrazo: dataPrazo ?? this.dataPrazo,
      metaRelacionada: metaRelacionada ?? this.metaRelacionada,
      descricao: descricao ?? this.descricao,
    );
  }

  /// Converte a tarefa em um mapa para gravar no Firestore.
  ///
  /// O `id` NÃO entra no mapa de propósito: no Firestore ele é o id do
  /// documento, então guardá-lo aqui dentro seria informação duplicada.
  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'trilhaNome': trilhaNome,
      'dataInicio': dataInicio,
      'dataPrazo': dataPrazo,
      'metaRelacionada': metaRelacionada,
      'descricao': descricao,
    };
  }

  /// Reconstrói uma tarefa a partir do id do documento e dos dados do
  /// Firestore. Usa `?? ''` para tolerar documentos com campos faltando,
  /// evitando erros de leitura.
  factory TarefaDetail.fromMap(String id, Map<String, dynamic> map) {
    return TarefaDetail(
      id: id,
      titulo: (map['titulo'] ?? '') as String,
      trilhaNome: (map['trilhaNome'] ?? '') as String,
      dataInicio: (map['dataInicio'] ?? '') as String,
      dataPrazo: (map['dataPrazo'] ?? '') as String,
      metaRelacionada: (map['metaRelacionada'] ?? '') as String,
      descricao: (map['descricao'] ?? '') as String,
    );
  }

  /// Dados mock para desenvolvimento e testes da tela de detalhe.
  static const mock = TarefaDetail(
    id: 'mock',
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
