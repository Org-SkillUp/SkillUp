import 'package:SkillUp/core/theme/state_button_theme.dart';
import 'package:SkillUp/core/widgets/bot_app_bar.dart';
import 'package:SkillUp/core/widgets/state_button.dart';
import 'package:SkillUp/core/widgets/top_app_bar.dart';
import 'package:SkillUp/features/tarefas/controllers/tarefa_form_controllers.dart';
import 'package:SkillUp/features/tarefas/data/tarefa_repository.dart';
import 'package:SkillUp/features/tarefas/routes/tarefas_navigation.dart';
import 'package:SkillUp/features/tarefas/routes/tarefas_routes.dart';
import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';
import 'package:SkillUp/features/tarefas/widgets/tarefa_description_card.dart';
import 'package:SkillUp/features/tarefas/widgets/tarefa_edit_form.dart';
import 'package:SkillUp/features/tarefas/widgets/tarefa_info_card.dart';
import 'package:flutter/material.dart';

class TarefaDetailPage extends StatefulWidget {
  const TarefaDetailPage({super.key, required this.tarefa});

  final TarefaDetail tarefa;

  @override
  State<TarefaDetailPage> createState() => _TarefaDetailPageState();
}

class _TarefaDetailPageState extends State<TarefaDetailPage> {
  // Cópia local da tarefa: começa com o valor recebido e é atualizada
  // sempre que o usuário salva uma edição.
  late TarefaDetail _tarefa;

  // Controladores dos campos do formulário de edição.
  late final TarefaFormControllers _controllers;

  // Controla o botão SALVAR já existente (desabilita após salvar).
  bool _isSaved = false;

  // Alterna entre o modo de visualização e o modo de edição da tarefa.
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _tarefa = widget.tarefa;
    _controllers = TarefaFormControllers(tarefa: _tarefa);
  }

  @override
  void dispose() {
    _controllers.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, {bool erro = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          // Vermelho em caso de erro; verde-azulado em caso de sucesso.
          backgroundColor:
              erro ? const Color(0xFFCF8080) : const Color(0xFF5A969A),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  void _handleSave() {
    if (_isSaved) return;

    setState(() => _isSaved = true);
    _showSnackBar('Alterações salvas com sucesso.');
  }

  void _enterEditMode() {
    // Recarrega os campos com os dados atuais, descartando edições
    // anteriores que não tenham sido salvas.
    _controllers.setFrom(_tarefa);
    setState(() => _isEditing = true);
  }

  void _cancelEdit() {
    setState(() => _isEditing = false);
  }

  Future<void> _saveEdit() async {
    // Preserva o id atual para que o Firestore atualize a tarefa certa,
    // em vez de criar uma nova.
    final atualizada = _controllers.toTarefa(id: _tarefa.id);

    try {
      await TarefaRepository.instance.atualizar(atualizada);

      if (!mounted) return;
      setState(() {
        _tarefa = atualizada;
        _isEditing = false;
      });
      _showSnackBar('Tarefa atualizada com sucesso.');
    } catch (_) {
      if (!mounted) return;
      _showSnackBar(
        'Não foi possível atualizar a tarefa. Tente novamente.',
        erro: true,
      );
    }
  }

  Future<void> _confirmarExclusao() async {
    final stButton = Theme.of(context).extension<StateButtonTheme>()!;

    // Pede confirmação antes de excluir, evitando remoções acidentais.
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir tarefa?'),
        content: const Text(
          'Esta ação não pode ser desfeita. A tarefa será removida da trilha.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: TextButton.styleFrom(
              foregroundColor: stButton.outlinedRedHighlighColor,
            ),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    // O diálogo é assíncrono: garante que o widget ainda está na árvore
    // antes de usar o context.
    if (confirmado != true || !mounted) return;

    try {
      await TarefaRepository.instance.remover(_tarefa.id);

      if (!mounted) return;
      TarefasNavigation.goToTrilhas(context);
    } catch (_) {
      if (!mounted) return;
      _showSnackBar(
        'Não foi possível excluir a tarefa. Tente novamente.',
        erro: true,
      );
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
            // Alterna o corpo da tela entre visualização e edição.
            if (_isEditing)
              _buildEditContent(stButton)
            else
              _buildViewContent(stButton),
          ],
        ),
      ),
      bottomNavigationBar: BotAppBar(
        selectedPage: TarefasRoutes.trilhas,
      ),
    );
  }

  /// Conteúdo somente leitura, com o botão de edição e as ações originais
  /// (SALVAR e CONCLUIR).
  Widget _buildViewContent(StateButtonTheme stButton) {
    final saveBgColor = _isSaved
        ? stButton.plainBackgroundColor.withAlpha((255 * 0.4).round())
        : stButton.plainBackgroundColor;
    final saveLabelColor = _isSaved
        ? stButton.plainLabelColor.withAlpha((255 * 0.5).round())
        : stButton.plainLabelColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _tarefa.titulo,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _tarefa.trilhaNome,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha((255 * 0.6).round()),
                    ),
                  ),
                ],
              ),
            ),
            // Affordance de edição: leva o conteúdo para o modo editável.
            IconButton(
              onPressed: _enterEditMode,
              tooltip: 'Editar tarefa',
              icon: const Icon(Icons.edit, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 20),
        TarefaInfoCard(tarefa: _tarefa),
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
        TarefaDescriptionCard(descricao: _tarefa.descricao),
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
          onPressed: () => TarefasNavigation.goToTrilhas(context),
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
        const SizedBox(height: 16),
        // Ação destrutiva: estilo vermelho contornado para deixar claro.
        StateButton(
          onPressed: _confirmarExclusao,
          icon: Icon(
            Icons.delete_outline,
            color: stButton.outlinedRedHighlighColor,
          ),
          label: Text(
            'EXCLUIR',
            style: TextStyle(
              color: stButton.outlinedRedHighlighColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          bgColor: stButton.outlinedBackgroundColor,
          borderColor: stButton.outlinedRedHighlighColor,
          borderRadius: 14,
        ),
      ],
    );
  }

  /// Conteúdo editável: reaproveita o mesmo formulário usado na criação
  /// de tarefas e oferece as ações de salvar e cancelar a edição.
  Widget _buildEditContent(StateButtonTheme stButton) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Editar Tarefa',
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
          onPressed: _saveEdit,
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
          onPressed: _cancelEdit,
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
    );
  }
}
