// core/widgets/select_options.dart
import 'package:SkillUp/core/widgets/field_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectOptions extends StatelessWidget {
  const SelectOptions({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
    this.allowCreation = false,
    this.onCreated,
  }) : assert(
    !allowCreation || onCreated != null,
    'Metódo de criação (onCreated) não fornecido',
  );

  final List<String> options;
  final String selected;
  final ValueChanged<String> onChanged;
  final bool allowCreation;
  final ValueChanged<String>? onCreated;

  static const _buttonColor = Color(0xFF2E4360);
  static const _borderRadius = 14.0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: _buttonColor,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: options.contains(selected) ? selected : null,
          dropdownColor: colorScheme.surface,
          iconEnabledColor: colorScheme.primary,
          icon: SvgPicture.asset(
            'assets/icons/arrow_down_icon.svg',
            colorFilter: ColorFilter.mode(
              colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
          style: textTheme.titleMedium?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.w700,
          ),
          isExpanded: true,
          borderRadius: BorderRadius.circular(_borderRadius),
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
          items: [
            ...options.map(
              (option) => DropdownMenuItem(
                value: option,
                child: Text(option),
              ),
            ),
            if (allowCreation)
              DropdownMenuItem<String>(
                enabled: false,
                value: '__create__',
                child: TextFieldBuilder.buildTextField(
                  hint: 'Criar Trilha',
                  fillColor: Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}