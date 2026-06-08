import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';

class ClassifiedList {
  ClassifiedList({
    this.classifier,
    required this.items,
  });

  String? classifier;
  List<TarefaDetail> items;
}