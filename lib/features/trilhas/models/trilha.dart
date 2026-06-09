import 'package:SkillUp/core/models/persistence_model.dart';
import 'package:SkillUp/features/tarefas/models/list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum TrilhaStatus {
  pending("Pendente"),
  active("Ativa"),
  paused("Pausada"),
  completed("Concluída");

  final String label;
  const TrilhaStatus(this.label);

  static TrilhaStatus fromString(String? value) {
    return TrilhaStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => TrilhaStatus.active,
    );
  }
}

class Trilha extends PersistenceModel {
  final String title;
  final TrilhaStatus status;
  final List<ClassifiedList> tarefas;
  final DateTime? startedAt;
  final DateTime? finishedAt;
  final DateTime? duedate;

  Trilha({
    super.id,
    super.createdAt,
    super.updatedAt,
    super.createdBy,
    required this.title,
    this.duedate,
    this.status = TrilhaStatus.pending,
    this.tarefas = const [],
    this.startedAt,
    this.finishedAt,
  });

  Trilha copyWith({
    String? title,
    TrilhaStatus? status,
    List<ClassifiedList>? tarefas,
    DateTime? startedAt,
    DateTime? finishedAt,
    DateTime? duedate,
  }) {
    return Trilha(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      createdBy: createdBy,
      title: title ?? this.title,
      duedate: duedate ?? this.duedate,
      status: status ?? this.status,
      tarefas: tarefas ?? this.tarefas,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
    );
  }

  factory Trilha.fromMap(Map<String, dynamic> map, String id) {
    return Trilha(
      id: id,
      title: map['title'] ?? '',
      duedate: (map['duedate'] as Timestamp?)?.toDate(),
      status: TrilhaStatus.fromString(map['status']),
      createdBy: map['createdBy'],
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate(),
      startedAt: (map['startedAt'] as Timestamp?)?.toDate(),
      finishedAt: (map['finishedAt'] as Timestamp?)?.toDate(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'duedate': duedate != null ? Timestamp.fromDate(duedate!) : null,
      'status': status.name,
      'startedAt': startedAt != null ? Timestamp.fromDate(startedAt!) : null,
      'finishedAt': finishedAt != null ? Timestamp.fromDate(finishedAt!) : null,
    };
  }
}