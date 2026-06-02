import 'package:SkillUp/core/theme/state_button_theme.dart';
import 'package:SkillUp/core/widgets/bot_app_bar.dart';
import 'package:SkillUp/core/widgets/state_button.dart';
import 'package:SkillUp/core/widgets/top_app_bar.dart';
import 'package:SkillUp/features/tarefas/data/tarefa_repository.dart';
import 'package:SkillUp/features/tarefas/controllers/tarefa_form_controllers.dart';
import 'package:SkillUp/features/tarefas/routes/tarefas_navigation.dart';
import 'package:SkillUp/features/tarefas/routes/tarefas_routes.dart';
import 'package:SkillUp/features/tarefas/widgets/tarefa_edit_form.dart';
import 'package:flutter/material.dart';

/// Tela de criação de tarefa.
///
/// É essencialmente a tela de detalhe em estado vazio/editável: reaproveita
/// o mesmo formulário ([TarefaEditForm]) e a mesma estrutura visual
/// (barras superior/inferior e botão "Voltar para Trilha").
class TarefaCreatePage extends StatefulWidget {
  const TarefaCreatePage({super.key});

  @override
  State<TarefaCreatePage> createState() => _TarefaCreatePageState();
}

class _TarefaCreatePageState extends State<TarefaCreatePage> {
  // Controladores iniciam vazios, pois não há tarefa pré-existente.
  late final TarefaFormControllers _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = TarefaFormControllers();
  }

  @override
  void dispose() {
    _controllers.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: const Color(0xFFCF8080),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  Future<void> _handleCreate() async {
    // Validação mínima: o título é obrigatório para identificar a tarefa.
    if (_controllers.titulo.text.trim().isEmpty) {
      _showErrorSnackBar('Informe ao menos o título da tarefa.');
      return;
    }

    try {
      // Grava a nova tarefa no Firestore (o id do documento é gerado lá).
      await TarefaRepository.instance.adicionar(_controllers.toTarefa());

      // Após o await, o context só pode ser usado se a tela ainda existe.
      if (!mounted) return;
      TarefasNavigation.goToTrilhas(context);
    } catch (_) {
      if (!mounted) return;
      _showErrorSnackBar('Não foi possível salvar a tarefa. Tente novamente.');
    }
  }

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
              onPressed: () => TarefasNavigation.goToTrilhas(context),
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
            const Text(
              'Nova Tarefa',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            TarefaEditForm(controllers: _controllers),
            const SizedBox(height: 24),
            StateButton(
              onPressed: _handleCreate,
              label: Text(
                'CRIAR TAREFA',
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
              onPressed: () => TarefasNavigation.goToTrilhas(context),
              label: Text(
                'CANCELAR',
                style: TextStyle(
                  color: stButton.outlinedYellowHighlighColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              bgColor: stButton.outlinedBackgroundColor,
              borderColor: stButton.outlinedYellowHighlighColor,
              borderRadius: 14,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BotAppBar(
        selectedPage: TarefasRoutes.trilhas,
      ),
    );
  }
}
