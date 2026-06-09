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
      orElse: () => TrilhaStatus.pending,
    );
  }

  bool canTransitionTo(TrilhaStatus next) {
    return switch (this) {
      TrilhaStatus.pending => next != TrilhaStatus.paused,
      TrilhaStatus.active => true,
      TrilhaStatus.completed => next != TrilhaStatus.paused,
      TrilhaStatus.paused => next != TrilhaStatus.completed,
    };
  }
}

class Trilha extends PersistenceModel {
  final String title;
  final TrilhaStatus status;
  final List<ClassifiedList> tarefas;
  final DateTime? startedAt;
  final DateTime? finishedAt;
  final DateTime? duedate;
  final DateTime? pausedAt;
  final DateTime? resumedAt;

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
    this.pausedAt,
    this.resumedAt,
  });

  static const _unset = Object();

  Trilha copyWith({
    String? title,
    TrilhaStatus? status,
    List<ClassifiedList>? tarefas,
    Object? startedAt = _unset,
    Object? finishedAt = _unset,
    Object? duedate = _unset,
    Object? pausedAt = _unset,
    Object? resumedAt = _unset,
  }) {
    return Trilha(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      createdBy: createdBy,
      title: title ?? this.title,
      status: status ?? this.status,
      tarefas: tarefas ?? this.tarefas,
      duedate:   identical(duedate,    _unset) ? this.duedate    : duedate    as DateTime?,
      startedAt: identical(startedAt,  _unset) ? this.startedAt  : startedAt  as DateTime?,
      finishedAt: identical(finishedAt, _unset) ? this.finishedAt : finishedAt as DateTime?,
      pausedAt:  identical(pausedAt,   _unset) ? this.pausedAt   : pausedAt   as DateTime?,
      resumedAt: identical(resumedAt,  _unset) ? this.resumedAt  : resumedAt  as DateTime?,
    );
  }

  factory Trilha.fromMap(Map<String, dynamic> map, String id) {
    return Trilha(
      id: id,
      title: map['title'] ?? '',
      status: TrilhaStatus.fromString(map['status']),
      createdBy: map['createdBy'] as String?,
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate(),
      duedate: (map['duedate'] as Timestamp?)?.toDate(),
      startedAt: (map['startedAt'] as Timestamp?)?.toDate(),
      finishedAt: (map['finishedAt'] as Timestamp?)?.toDate(),
      pausedAt: (map['pausedAt'] as Timestamp?)?.toDate(),
      resumedAt: (map['resumedAt'] as Timestamp?)?.toDate(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'status': status.name,
      'duedate': duedate != null ? Timestamp.fromDate(duedate!) : null,
      'startedAt': startedAt != null ? Timestamp.fromDate(startedAt!) : null,
      'finishedAt': finishedAt != null ? Timestamp.fromDate(finishedAt!) : null,
      'pausedAt': pausedAt != null ? Timestamp.fromDate(pausedAt!) : null,
      'resumedAt': resumedAt != null ? Timestamp.fromDate(resumedAt!) : null,
    };
  }
}