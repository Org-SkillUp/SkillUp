import 'package:SkillUp/core/models/persistence_model.dart';

/// Dados exibidos na tela de detalhe de uma tarefa.
class TarefaDetail extends PersistenceModel {
  const TarefaDetail({
    super.id,
    super.createdAt,
    super.updatedAt,
    super.createdBy,
    super.updatedBy,
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

  TarefaDetail copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    String? updatedBy,
    String? titulo,
    String? trilhaNome,
    String? dataInicio,
    String? dataPrazo,
    String? metaRelacionada,
    String? descricao,
  }) {
    return TarefaDetail(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      titulo: titulo ?? this.titulo,
      trilhaNome: trilhaNome ?? this.trilhaNome,
      dataInicio: dataInicio ?? this.dataInicio,
      dataPrazo: dataPrazo ?? this.dataPrazo,
      metaRelacionada: metaRelacionada ?? this.metaRelacionada,
      descricao: descricao ?? this.descricao,
    );
  }

  @override
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

  /// Reconstrói a tarefa a partir do documento Firestore.
  factory TarefaDetail.fromMap(Map<String, dynamic> map, String id) {
    return TarefaDetail(
      id: id,
      createdAt: PersistenceModel.parseTimestamp(map['createdAt']),
      updatedAt: PersistenceModel.parseTimestamp(map['updatedAt']),
      createdBy: map['createdBy'] as String?,
      updatedBy: map['updatedBy'] as String?,
      titulo: (map['titulo'] ?? '') as String,
      trilhaNome: (map['trilhaNome'] ?? '') as String,
      dataInicio: (map['dataInicio'] ?? '') as String,
      dataPrazo: (map['dataPrazo'] ?? '') as String,
      metaRelacionada: (map['metaRelacionada'] ?? '') as String,
      descricao: (map['descricao'] ?? '') as String,
    );
  }

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
