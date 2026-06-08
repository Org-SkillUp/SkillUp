import 'package:SkillUp/core/theme/state_button_theme.dart';
import 'package:SkillUp/core/widgets/bot_app_bar.dart';
import 'package:SkillUp/core/widgets/state_button.dart';
import 'package:SkillUp/core/widgets/top_app_bar.dart';
import 'package:SkillUp/features/auth/routes/auth_routes.dart';
import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';
import 'package:SkillUp/features/tarefas/widgets/tarefa_description_card.dart';
import 'package:SkillUp/features/tarefas/widgets/tarefa_info_card.dart';
import 'package:flutter/material.dart';

class TarefaDetailPage extends StatefulWidget {
  const TarefaDetailPage({super.key, required this.tarefa});

  final TarefaDetail tarefa;

  @override
  State<TarefaDetailPage> createState() => _TarefaDetailPageState();
}

class _TarefaDetailPageState extends State<TarefaDetailPage> {
  bool _isSaved = false;

  void _handleSave() {
    if (_isSaved) return;

    setState(() => _isSaved = true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: const Text('Alterações salvas com sucesso.'),
            backgroundColor: const Color(0xFF5A969A),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    final stButton = Theme.of(context).extension<StateButtonTheme>()!;
    final saveBgColor = _isSaved
        ? stButton.plainBackgroundColor.withAlpha((255 * 0.4).round())
        : stButton.plainBackgroundColor;
    final saveLabelColor = _isSaved
        ? stButton.plainLabelColor.withAlpha((255 * 0.5).round())
        : stButton.plainLabelColor;

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
              widget.tarefa.titulo,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              // TODO: buscar nome da trilha a partir do ID
              /*widget.tarefa.trilhaNome*/
              "Trilha",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withAlpha((255 * 0.6).round()),
              ),
            ),
            const SizedBox(height: 20),
            TarefaInfoCard(tarefa: widget.tarefa),
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
            TarefaDescriptionCard(descricao: widget.tarefa.descricao ?? ""),
            const SizedBox(height: 24),
            StateButton(
              onPressed: _isSaved ? null : _handleSave,
              label: Text(
                'SALVAR',
                style: TextStyle(
                  color: saveLabelColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              bgColor: saveBgColor,
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
        selectedPage: AuthRoutes.tarefas,
      ),
    );
  }
}
