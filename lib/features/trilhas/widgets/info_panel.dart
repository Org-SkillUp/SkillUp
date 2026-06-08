import 'package:SkillUp/core/theme/state_button_theme.dart';
import 'package:SkillUp/core/theme/status_theme.dart';
import 'package:SkillUp/core/widgets/date_indicator_wrapper.dart';
import 'package:SkillUp/core/widgets/field_builder.dart';
import 'package:SkillUp/core/widgets/indicator.dart';
import 'package:SkillUp/core/widgets/state_button.dart';
import 'package:SkillUp/features/trilhas/models/trilha.dart';
import 'package:SkillUp/features/trilhas/viewmodels/trilha_view_model.dart';
import 'package:flutter/material.dart';

class InfoPanel extends StatelessWidget {
  const InfoPanel({
    super.key,
    required this.selected,
    required this.vm,
    required this.trilhaNomeController,
  });

  final Trilha selected;
  final TrilhasViewModel vm;
  final TextEditingController trilhaNomeController;

  Color _statusColor(BuildContext context, TrilhaStatus? status) {
    final nav = Theme.of(context).extension<StatusTheme>()!;
    return switch (status) {
      TrilhaStatus.active => nav.activeColor,
      TrilhaStatus.paused => nav.pausedColor,
      TrilhaStatus.completed => nav.completedColor,
      TrilhaStatus.pending => nav.pendingColor,
      null => const Color.fromARGB(255, 0, 0, 0),
    };
  }

  bool get _showButtons => selected.startedAt != null;

  @override
  Widget build(BuildContext context) {
    final stButton = Theme.of(context).extension<StateButtonTheme>()!;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: DateIndicatorWrapper(
            trilha: selected,
            onDueDateSelected: vm.updateDueDate,
            onStartDateSelected: vm.updateStartDate,
            onFinishDateSelected: vm.updateFinishDate,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Indicator(
                  icon: Icons.circle,
                  label: 'Status',
                  value: selected.status.label,
                  dotColor: _statusColor(context, selected.status),
                  valueColor: _statusColor(context, selected.status),
                  selectOptions: TrilhaStatus.values.map((s) => s.label).toList(),
                  onSelect: (label) {
                    final novoStatus = TrilhaStatus.values.firstWhere(
                      (s) => s.label == label,
                    );
                    vm.updateStatus(novoStatus);
                  },
                ),

                if (_showButtons) ...[
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

                  if (vm.isCreating) ...[
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
                    const SizedBox(height: 12),
                  ],

                  StateButton(
                    onPressed: () => vm.setCreating(true),
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
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}