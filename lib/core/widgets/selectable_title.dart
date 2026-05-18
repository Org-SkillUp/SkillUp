import 'package:SkillUp/core/widgets/select_options.dart';
import 'package:flutter/material.dart';

class SelectableTitle extends StatelessWidget {
  const SelectableTitle({
    super.key,
    required this.label,
    this.underLabel,
    required this.options,
    required this.selected,
    required this.onChanged,
    this.allowCreation = false,
    this.onCreated,
  });

  final String label;
  final String? underLabel;
  final List<String> options;
  final String selected;
  final ValueChanged<String> onChanged;
  final bool allowCreation;
  final ValueChanged<String>? onCreated;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: textTheme.labelMedium?.copyWith(
            color: colorScheme.primary.withAlpha(153),
          ),
        ),
        const SizedBox(height: 8),

        SelectOptions(
          options: options,
          selected: selected,
          onChanged: onChanged,
          allowCreation: allowCreation,
          onCreated: onCreated,
        ),

        if (underLabel != null) ...[
          const SizedBox(height: 8),
          Text(
            underLabel!,
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.primary.withAlpha(153),
            ),
          ),
        ],
      ],
    );
  }
}