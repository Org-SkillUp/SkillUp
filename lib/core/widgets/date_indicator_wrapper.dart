import 'package:SkillUp/core/widgets/indicator.dart';
import 'package:SkillUp/features/trilhas/models/trilha.dart';
import 'package:flutter/material.dart';

class DateIndicatorWrapper extends StatefulWidget {
  const DateIndicatorWrapper({
    super.key,
    required this.trilha,
    required this.onDueDateSelected,
    required this.onStartDateSelected,
    required this.onFinishDateSelected,
  });

  final Trilha trilha;
  final ValueChanged<DateTime> onDueDateSelected;
  final ValueChanged<DateTime> onStartDateSelected;
  final ValueChanged<DateTime> onFinishDateSelected;

  @override
  State<DateIndicatorWrapper> createState() => _DateIndicatorWrapperState();
}

class _DateIndicatorWrapperState extends State<DateIndicatorWrapper> {
  String _formatDate(DateTime? date) {
    if (date == null) return 'Indefinido';
    return '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/'
      '${date.year}';
  }

  bool get _showStart =>
    widget.trilha.duedate != null || widget.trilha.startedAt != null;

  bool get _showFinish =>
    widget.trilha.startedAt != null || widget.trilha.finishedAt != null;

  Future<void> _pickDate({
    required DateTime? initial,
    required DateTime firstDate,
    required DateTime lastDate,
    required ValueChanged<DateTime> onPicked,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initial ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (!mounted) return;
    if (picked != null) onPicked(picked);
  }

  @override
  Widget build(BuildContext context) {
    final mutedColor = Theme.of(context).colorScheme.primary.withAlpha(100);
    final trilha = widget.trilha;

    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Indicator(
            icon: Icons.flag_outlined,
            label: 'Prazo',
            value: trilha.duedate == null
                ? 'Não Informado'
                : _formatDate(trilha.duedate),
            onDateSelect: () => _pickDate(
              initial: trilha.duedate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              onPicked: widget.onDueDateSelected,
            ),
          ),

          if (_showStart) ...[
            const SizedBox(height: 12),
            Indicator(
              icon: Icons.calendar_today_outlined,
              label: 'Início',
              value: trilha.startedAt == null
                  ? 'Quando iniciar'
                  : _formatDate(trilha.startedAt),
              valueColor: trilha.startedAt == null ? mutedColor : null,
              onDateSelect: () => _pickDate(
                initial: trilha.startedAt,
                firstDate: DateTime(2000),
                lastDate: trilha.duedate ?? DateTime(2100),
                onPicked: widget.onStartDateSelected,
              ),
            ),
          ],

          if (_showFinish) ...[
            const SizedBox(height: 12),
            Indicator(
              icon: Icons.check,
              label: 'Conclusão',
              value: trilha.finishedAt == null
                  ? 'Quando concluir'
                  : _formatDate(trilha.finishedAt),
              valueColor: trilha.finishedAt == null ? mutedColor : null,
              onDateSelect: () => _pickDate(
                initial: trilha.finishedAt,
                firstDate: trilha.startedAt ?? DateTime(2000),
                lastDate: DateTime(2100),
                onPicked: widget.onFinishDateSelected,
              ),
            ),
          ],
        ],
      ),
    );
  }
}