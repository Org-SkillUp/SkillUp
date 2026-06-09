import 'package:SkillUp/core/theme/state_button_theme.dart';
import 'package:SkillUp/core/widgets/field_builder.dart';
import 'package:SkillUp/core/widgets/state_button.dart';
import 'package:SkillUp/features/trilhas/models/trilha.dart';
import 'package:SkillUp/features/trilhas/viewmodels/trilha_view_model.dart';
import 'package:flutter/material.dart';

class CreationButtons extends StatelessWidget {
  const CreationButtons({
    super.key,
    required this.selected,
    required this.vm,
    required this.trilhaNomeController
  });

  final Trilha selected;
  final TrilhasViewModel vm;
  final TextEditingController trilhaNomeController;

  @override
  Widget build(BuildContext context) {
    final stButton = Theme.of(context).extension<StateButtonTheme>()!;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        const SizedBox(height: 12),

        StateButton(
          onPressed: vm.togglePause,
          label: Text(
            vm.isPaused ? 'RETOMAR' : 'PAUSAR',
            style: TextStyle(
              color: stButton.outlinedYellowHighlighColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'Arimo',
              fontSize: 16,
            ),
          ),
          bgColor: stButton.outlinedBackgroundColor,
          borderColor: stButton.outlinedYellowHighlighColor,
          borderRadius: 14,
        ),

        const SizedBox(height: 12),

        StateButton(
          onPressed: () => vm.setCreating(!vm.isCreating),
          label: Text(
            'NOVA TRILHA',
            style: TextStyle(
              color: stButton.plainLabelColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'Arimo',
              fontSize: 16,
            ),
          ),
          bgColor: stButton.plainBackgroundColor,
          borderRadius: 16,
          icon: Icon(Icons.add, color: stButton.plainLabelColor),
        ),

        if (vm.isCreating) ...[
          const SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: ElevatedButton(
                  onPressed: () async {
                    await vm.createTrilha(trilhaNomeController.text);
                    trilhaNomeController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: stButton.plainBackgroundColor,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: Icon(
                    Icons.check,
                    color: stButton.plainLabelColor,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFieldBuilder.buildTextField(
                  hint: "Nome da Trilha",
                  fillColor: colorScheme.surface,
                  controller: trilhaNomeController,
                ),
              ),
            ],
          ),
        ],
      ]
    );
  }
}