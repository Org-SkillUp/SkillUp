import 'package:SkillUp/models/persistence_model.dart';
import 'package:SkillUp/features/trilhas/models/list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum TrilhaStatus {
  pending("Pendente"),
  active("Ativa"),
  paused("Pausada"),
  completed("Concluída"),
  canceled("Cancelada");

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
  final String subtitle;
  final TrilhaStatus status;
  final List<ClassifiedList> tarefas;
  final DateTime? startedAt;
  final DateTime? finishedAt;
  final DateTime duedate;

  Trilha({
    super.id,
    super.createdAt,
    super.updatedAt,
    super.createdBy,
    required this.title,
    required this.subtitle,
    required this.duedate,
    this.status = TrilhaStatus.pending,
    this.tarefas = const [],
    this.startedAt,
    this.finishedAt,
  });

  Trilha copyWith({
    String? title,
    String? subtitle,
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
      subtitle: subtitle ?? this.subtitle,
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
      subtitle: map['subtitle'] ?? '',
      duedate: (map['duedate'] as Timestamp?)?.toDate() ?? DateTime.now(),
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
      'subtitle': subtitle,
      'duedate': Timestamp.fromDate(duedate),
      'status': status.name,
      'startedAt': startedAt != null ? Timestamp.fromDate(startedAt!) : null,
      'finishedAt': finishedAt != null ? Timestamp.fromDate(finishedAt!) : null,
    };
  }

  // TODO: remover mock
  static List<Trilha> get mock => [
    Trilha(
      id: '1',
      title: 'Administração de Empresas',
      subtitle: 'Gestão e finanças',
      duedate: DateTime(2026, 12, 31),
      startedAt: DateTime(2026, 3, 14),
      status: TrilhaStatus.active,
      tarefas: [
        ClassifiedList(
          classifier: 'Prova Gestão de Vendas',
          items: [
            ListItem(
              title: 'Estudar Canais de Vendas',
              subtitle: 'Prova gestão de vendas',
              onTap: (_) {},
              isSelected: true,
              date: '14/03/2026',
            ),
          ],
        ),
        ClassifiedList(
          classifier: 'Prova Administração Financeira',
          items: [
            ListItem(
              title: 'Estudar Fluxo de Caixa',
              subtitle: 'Prova administração financeira',
              onTap: (_) {},
              isSelected: false,
              date: '20/04/2026',
            ),
          ],
        ),
      ],
    ),
    Trilha(
      id: '2',
      title: 'Tecnologia',
      subtitle: 'Desenvolvimento de software',
      duedate: DateTime(2026, 12, 31),
      startedAt: DateTime(2026, 1, 10),
      status: TrilhaStatus.paused,
      tarefas: [
        ClassifiedList(
          classifier: 'Projeto Flutter',
          items: [
            ListItem(
              title: 'Integrar Firebase',
              subtitle: 'Projeto final',
              onTap: (_) {},
              isSelected: false,
              date: '09/06/2026',
            ),
          ],
        ),
      ],
    ),
  ];
}