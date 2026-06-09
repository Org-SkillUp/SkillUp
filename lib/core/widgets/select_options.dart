import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectOptions extends StatelessWidget {
  const SelectOptions({
    super.key,
    required this.options,
    required this.selected,
    required this.selectedLabel,
    required this.onChanged,
  });

  final Map<String, String> options;
  final String selected;
  final String selectedLabel;
  final ValueChanged<String> onChanged;

  static const _buttonColor = Color(0xFF2E4360);
  static const _borderRadius = 14.0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return DropdownMenu<String>(
      initialSelection: options.keys.contains(selected) ? selected : null,
      enableSearch: true,
      enableFilter: true,
      requestFocusOnTap: true,
      expandedInsets: EdgeInsets.zero,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _buttonColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide.none,
        ),
      ),
      textStyle: textTheme.titleMedium?.copyWith(
        color: colorScheme.primary,
        fontWeight: FontWeight.w700,
        fontFamily: 'Arimo',
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(colorScheme.surface),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
        ),
      ),
      trailingIcon: SvgPicture.asset(
        'assets/icons/arrow_down_icon.svg',
        colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
      ),
      selectedTrailingIcon: SvgPicture.asset(
        'assets/icons/arrow_down_icon.svg',
        colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
      ),
      onSelected: (value) {
        if (value != null) onChanged(value);
      },
      dropdownMenuEntries: options.entries.map(
        (option) => DropdownMenuEntry<String>(
          value: option.key,
          label: option.value,
          style: ButtonStyle(
            textStyle: WidgetStatePropertyAll(
              textTheme.bodyMedium?.copyWith(fontFamily: 'Arimo'),
            ),
          ),
        ),
      ).toList(),
    );
  }
}