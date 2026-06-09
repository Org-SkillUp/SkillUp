import 'package:cloud_firestore/cloud_firestore.dart';

class ContaModel {
  const ContaModel({required this.trilhasAtivas, required this.tarefas});

  final int trilhasAtivas;
  final List<ContaTarefaModel> tarefas;

  int get metasCriadas => tarefas.length;
  int get habilidades => tarefas.length;
}

class ContaTarefaModel {
  const ContaTarefaModel({
    required this.title,
    required this.goal,
    required this.date,
  });

  final String title;
  final String goal;
  final DateTime? date;

  factory ContaTarefaModel.fromMap(Map<String, dynamic> map) {
    final metaRelacionada = _readString(map['metaRelacionada']);
    final descricao = _readString(map['descricao']);

    return ContaTarefaModel(
      title: _readString(map['titulo']) ?? 'Sem título',
      goal: metaRelacionada ?? descricao ?? 'Sem meta relacionada',
      date:
          _readDate(map['dataPrazo']) ??
          _readDate(map['dataConclusao']) ??
          _readDate(map['dataInicio']),
    );
  }

  static String? _readString(dynamic value) {
    if (value is! String) return null;

    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  static DateTime? _readDate(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;

    return null;
  }
}
