import 'package:SkillUp/core/theme/state_button_theme.dart';
import 'package:SkillUp/core/widgets/bot_app_bar.dart';
import 'package:SkillUp/core/widgets/selectable_title.dart';
import 'package:SkillUp/core/widgets/state_button.dart';
import 'package:SkillUp/core/widgets/top_app_bar.dart';
import 'package:SkillUp/features/auth/routes/auth_routes.dart';
import 'package:SkillUp/features/trilhas/models/trilha.dart';
import 'package:flutter/material.dart';

class BlankTrilhasView extends StatefulWidget {
  final Future<void> Function(Trilha trilha) onCreateTrilha;

  const BlankTrilhasView({super.key, required this.onCreateTrilha});

  @override
  State<BlankTrilhasView> createState() => _BlankTrilhasViewState();
}

class _BlankTrilhasViewState extends State<BlankTrilhasView> {
  final _trilhaNomeController = TextEditingController();
  bool _isCreating = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _trilhaNomeController.addListener(() {
      final hasText = _trilhaNomeController.text.trim().isNotEmpty;
      if (hasText != _hasText) setState(() => _hasText = hasText);
    });
  }

  @override
  void dispose() {
    _trilhaNomeController.dispose();
    super.dispose();
  }

  Future<void> _confirmar() async {
    final name = _trilhaNomeController.text.trim();
    if (name.isEmpty) return;

    await widget.onCreateTrilha(
      Trilha(
        title: name,
      )
    );

    if (!mounted) return;

    _trilhaNomeController.clear();
    setState(() => _isCreating = false);
  }

  @override
  Widget build(BuildContext context) {
    final stButton = Theme.of(context).extension<StateButtonTheme>()!;

    final buttonLabel = _hasText ? 'CRIAR' : 'NOVA TRILHA';
    final buttonColor = _hasText ? stButton.createBackgroundColor : stButton.plainBackgroundColor;
    final buttonIcon = _hasText ? Icons.check : Icons.add;

    return Scaffold(
      appBar: TopAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (_isCreating) ...[
                SelectableTitle(
                  label: 'Nova Trilha',
                  selectedLabel: '',
                  options: const {},
                  selected: '',
                  onChanged: (_) {},
                  allowCreation: true,
                  controller: _trilhaNomeController,
                ),
                const SizedBox(height: 12),
              ],

              StateButton(
                onPressed: () {
                  if (!_isCreating) {
                    setState(() => _isCreating = true);
                  } else if (_hasText) {
                    _confirmar();
                  }
                },
                label: Text(
                  buttonLabel,
                  style: TextStyle(
                    color: stButton.plainLabelColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arimo',
                    fontSize: 16,
                  ),
                ),
                bgColor: buttonColor,
                borderRadius: 16,
                icon: Icon(buttonIcon, color: stButton.plainLabelColor),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BotAppBar(selectedPage: AuthRoutes.trilhas),
    );
  }
}