import 'package:SkillUp/core/theme/state_button_theme.dart';
import 'package:SkillUp/core/widgets/bot_app_bar.dart';
import 'package:SkillUp/core/widgets/state_button.dart';
import 'package:SkillUp/core/widgets/top_app_bar.dart';
import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';
import 'package:SkillUp/features/tarefas/widgets/tarefa_description_card.dart';
import 'package:SkillUp/features/tarefas/widgets/tarefa_info_card.dart';
import 'package:flutter/material.dart';

class TarefaDetailPage extends StatelessWidget {
  const TarefaDetailPage({super.key, required this.tarefa});

  final TarefaDetail tarefa;

  @override
  Widget build(BuildContext context) {
    final stButton = Theme.of(context).extension<StateButtonTheme>()!;

    return Scaffold(
      appBar: const TopAppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextButton.icon(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.zero,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.arrow_back, size: 20),
              label: const Text(
                'Voltar para Trilha',
                style: TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              tarefa.titulo,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              tarefa.trilhaNome,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withAlpha((255 * 0.6).round()),
              ),
            ),
            const SizedBox(height: 20),
            TarefaInfoCard(tarefa: tarefa),
            const SizedBox(height: 20),
            const Text(
              'Descrição',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            TarefaDescriptionCard(descricao: tarefa.descricao),
            const SizedBox(height: 24),
            StateButton(
              onPressed: () {},
              label: Text(
                'SALVAR',
                style: TextStyle(
                  color: stButton.plainLabelColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              bgColor: stButton.plainBackgroundColor,
              borderRadius: 14,
            ),
            const SizedBox(height: 16),
            StateButton(
              onPressed: () {},
              label: Text(
                'CONCLUIR',
                style: TextStyle(
                  color: stButton.outlinedGreenHighlighColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              bgColor: stButton.outlinedBackgroundColor,
              borderColor: stButton.outlinedGreenHighlighColor,
              borderRadius: 14,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BotAppBar(
        selectedIndex: 1,
        onTabChanged: (_) {},
      ),
    );
  }
}
