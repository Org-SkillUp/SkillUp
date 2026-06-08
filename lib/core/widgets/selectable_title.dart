import 'package:SkillUp/core/widgets/field_builder.dart';
import 'package:SkillUp/core/widgets/select_options.dart';
import 'package:flutter/material.dart';

class SelectableTitle extends StatefulWidget {
  const SelectableTitle({
    super.key,
    required this.label,
    required this.selectedLabel,
    this.underLabel,
    required this.options,
    required this.selected,
    required this.onChanged,
    this.allowCreation = false,
    this.controller,
  });

  final String label;
  final String selectedLabel;
  final String? underLabel;
  final Map<String, String> options;
  final String selected;
  final ValueChanged<String> onChanged;
  final bool allowCreation;
  final TextEditingController? controller;

  @override
  State<SelectableTitle> createState() => _SelectableTitleState();
}

class _SelectableTitleState extends State<SelectableTitle> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final showTextField = widget.allowCreation && widget.options.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.label,
          style: textTheme.labelMedium?.copyWith(
            color: colorScheme.primary.withAlpha(153),
            fontFamily: 'Arimo',
          ),
        ),
        const SizedBox(height: 8),

        if (showTextField)
          TextFieldBuilder.buildTextField(
            hint: "Nome da Trilha",
            fillColor: colorScheme.surface,
            controller: _controller,
          )
        else
          SelectOptions(
            options: widget.options,
            selected: widget.selected,
            selectedLabel: widget.selectedLabel,
            onChanged: widget.onChanged,
          ),

        if (widget.underLabel != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.underLabel!,
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.primary.withAlpha(153),
              fontFamily: 'Arimo',
            ),
          ),
        ],
      ],
    );
  }
}