import 'package:flutter/material.dart';

class SelectableValue extends StatefulWidget {
  const SelectableValue({
    super.key, 
    required this.value,
    required this.valueColor,
    required this.textTheme,
    required this.fontSize,
    required this.selectOptions,
    required this.onSelect,
    required this.anchorKey,
  });

  final String value;
  final Color valueColor;
  final TextTheme textTheme;
  final double fontSize;
  final List<String> selectOptions;
  final ValueChanged<String> onSelect;
  final GlobalKey anchorKey;

  @override
  State<SelectableValue> createState() => _SelectableValueState();
}

class _SelectableValueState extends State<SelectableValue> {
  Future<void> _openMenu() async {
    final box = widget.anchorKey.currentContext!.findRenderObject() as RenderBox;
    final overlay = Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;

    final anchorWidth = box.size.width;

    final colorScheme = Theme.of(context).colorScheme;

    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        box.localToGlobal(box.size.bottomLeft(Offset.zero), ancestor: overlay),
        box.localToGlobal(box.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final picked = await showMenu<String>(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: colorScheme.surface,
      constraints: BoxConstraints(
        minWidth: anchorWidth,
        maxWidth: anchorWidth,
      ),
      items: widget.selectOptions.map(
        (option) => PopupMenuItem<String>(
          value: option,
          child: Text(
            option,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ).toList(),
    );

    if (!mounted) return;
    if (picked != null) widget.onSelect(picked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openMenu,
      child: Row(
        children: [
          Text(
            widget.value,
            style: widget.textTheme.titleMedium?.copyWith(
              color: widget.valueColor,
              fontWeight: FontWeight.bold,
              fontSize: widget.fontSize,
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.arrow_drop_down, size: 18, color: widget.valueColor),
        ],
      ),
    );
  }
}