import 'package:SkillUp/core/theme/status_theme.dart';
import 'package:SkillUp/core/widgets/date_indicator_wrapper.dart';
import 'package:SkillUp/core/widgets/indicator.dart';
import 'package:SkillUp/features/trilhas/models/trilha.dart';
import 'package:SkillUp/features/trilhas/viewmodels/trilha_view_model.dart';
import 'package:SkillUp/features/trilhas/widgets/creation_buttons.dart';
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

  @override
  Widget build(BuildContext context) {

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
                  selectOptions: TrilhaStatus.values
                    .where((s) => s != selected.status && selected.status.canTransitionTo(s))
                    .map((s) => s.label)
                    .toList(),                  
                  onSelect: (label) {
                    final novoStatus = TrilhaStatus.values.firstWhere(
                      (s) => s.label == label,
                    );
                    vm.updateStatus(novoStatus);
                  },
                ),

                if (vm.showButtonsInPanel) ...[
                  CreationButtons(
                    selected: selected, 
                    vm: vm, 
                    trilhaNomeController: trilhaNomeController
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