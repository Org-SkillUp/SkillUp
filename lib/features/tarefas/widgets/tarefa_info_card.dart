import 'package:SkillUp/core/theme/card_item_theme.dart';
import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';
import 'package:SkillUp/features/tarefas/widgets/tarefa_info_row.dart';
import 'package:flutter/material.dart';

class TarefaInfoCard extends StatelessWidget {
  const TarefaInfoCard({super.key, required this.tarefa});

  final TarefaDetail tarefa;

  @override
  Widget build(BuildContext context) {
    final cardColor =
        Theme.of(context).extension<CardItemTheme>()!.backgroundColor;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TarefaInfoRow(label: 'Iniciado', value: tarefa.dataInicio?.toString() ?? 'Não iniciado'),
          TarefaInfoRow(label: 'Prazo', value: tarefa.dataPrazo?.toString() ?? 'Não definido'),
          TarefaInfoRow(
            label: 'Meta Relacionada',
            value: tarefa.metaRelacionada ?? "Nenhuma",
          ),
        ],
      ),
    );
  }
}
