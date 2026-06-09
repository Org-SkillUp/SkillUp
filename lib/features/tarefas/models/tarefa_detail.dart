import 'package:SkillUp/core/models/persistence_model.dart';
import 'package:SkillUp/features/tarefas/models/list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TarefaDetail extends PersistenceModel implements ListItem {
  TarefaDetail({
    super.id,
    super.createdAt,
    super.updatedAt,
    super.createdBy,
    super.updatedBy,
    required this.titulo,
    required this.trilhaId,
    this.trilhaNome,
    this.dataInicio,
    this.dataPrazo,
    this.dataConclusao,
    this.metaRelacionada,
    this.descricao,
    this.concluida = false,
    this.onOpen,
  });

  final String titulo;
  final String trilhaId;
  final String? trilhaNome;
  DateTime? dataInicio;
  DateTime? dataPrazo;
  DateTime? dataConclusao;
  String? metaRelacionada;
  String? descricao;
  bool concluida;

  @override
  String get title => titulo;

  @override
  String? get subtitle => "Meta: $metaRelacionada";

  @override
  bool get isSelected => concluida;

  @override
  DateTime? get date => dataPrazo;

  @override
  final VoidCallback? onOpen;

  @override
  void onTap() => concluida = !concluida;

  TarefaDetail copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    String? updatedBy,
    String? titulo,
    String? trilhaId,
    String? trilhaNome,
    DateTime? dataInicio,
    DateTime? dataPrazo,
    DateTime? dataConclusao,
    String? metaRelacionada,
    String? descricao,
    bool? concluida,
    VoidCallback? onOpen,
  }) {
    return TarefaDetail(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      titulo: titulo ?? this.titulo,
      trilhaId: trilhaId ?? this.trilhaId,
      trilhaNome: trilhaNome ?? this.trilhaNome,
      dataInicio: dataInicio ?? this.dataInicio,
      dataPrazo: dataPrazo ?? this.dataPrazo,
      dataConclusao: dataConclusao ?? this.dataConclusao,
      metaRelacionada: metaRelacionada ?? this.metaRelacionada,
      descricao: descricao ?? this.descricao,
      concluida: concluida ?? this.concluida,
      onOpen: onOpen ?? this.onOpen,
    );
  }

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
      'concluida': concluida,
    };
  }

  factory TarefaDetail.fromMap(Map<String, dynamic> map, String id) {
    return TarefaDetail(
      id: id,
      createdAt: PersistenceModel.parseTimestamp(map['createdAt']),
      updatedAt: PersistenceModel.parseTimestamp(map['updatedAt']),
      createdBy: map['createdBy'] as String?,
      updatedBy: map['updatedBy'] as String?,
      titulo: map['titulo'] ?? '',
      trilhaId: map['trilhaId'] ?? '',
      dataInicio: _parseDate(map['dataInicio']),
      dataPrazo: _parseDate(map['dataPrazo']),
      dataConclusao: _parseDate(map['dataConclusao']),
      metaRelacionada: map['metaRelacionada'] as String?,
      descricao: map['descricao'] as String?,
      concluida: map['concluida'] as bool? ?? false,
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  static final mock = TarefaDetail(
    id: 'mock',
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