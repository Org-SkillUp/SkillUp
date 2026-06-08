import 'package:SkillUp/core/models/persistence_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Dados exibidos na tela de detalhe de uma tarefa.
class TarefaDetail extends PersistenceModel {
  TarefaDetail({
      super.id,
    super.createdAt,
    super.updatedAt,
    super.createdBy,
    required this.titulo,
    required this.trilhaId,
    this.dataInicio,
    this.dataPrazo,
    this.dataConclusao,
    this.metaRelacionada,
    this.descricao,
  });


  final String titulo;
  final String trilhaId;
  DateTime? dataInicio;
  DateTime? dataPrazo;
  DateTime? dataConclusao;
  String? metaRelacionada;
  String? descricao;

  @override
  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'trilhaId': trilhaId,
      'dataInicio': dataInicio != null ? Timestamp.fromDate(dataInicio!) : null,
      'dataPrazo': dataPrazo != null ? Timestamp.fromDate(dataPrazo!) : null,
      'dataConclusao': dataConclusao != null ? Timestamp.fromDate(dataConclusao!) : null,
      'metaRelacionada': metaRelacionada,
      'descricao': descricao,
    };
  }

  factory TarefaDetail.fromMap(Map<String, dynamic> map, String id) {
    return TarefaDetail(
      id: id,
      titulo: map['titulo'] ?? '',
      trilhaId: map['trilhaId'] ?? '',
      dataInicio: (map['dataInicio'] as Timestamp?)?.toDate(),
      dataPrazo: (map['dataPrazo'] as Timestamp?)?.toDate(),
      dataConclusao: (map['dataConclusao'] as Timestamp?)?.toDate(),
      metaRelacionada: map['metaRelacionada'],
      descricao: map['descricao'],
    );
  }

  /// Dados mock para desenvolvimento e testes da tela de detalhe.
  static final mock = TarefaDetail(
    titulo: 'Estudar Fluxo de Caixa',
    trilhaId: 'trilha-1',
    dataInicio: DateTime(2026, 4, 18),
    dataPrazo: DateTime(2026, 4, 20),
    dataConclusao: DateTime(2026, 4, 20),
    metaRelacionada: 'Prova administração financeira',
    descricao:
        'Leitura do material didático sobre gestão de tesouraria e resolução '
        'dos 5 exercícios práticos de projeção financeira da Unidade 2. '
        'Prazo final para envio do relatório de progresso: 20/04/2026.',
  );
}
