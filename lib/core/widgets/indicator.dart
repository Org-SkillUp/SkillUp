import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.valueColor,
    this.dotColor,
  });

  final String label;
  final String value;
  final IconData? icon;
  final Color? valueColor;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final muted = colorScheme.primary.withAlpha(153);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (dotColor != null) ...[
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
              ] else ...[
                Icon(icon, size: 12, color: muted),
                const SizedBox(width: 8),
              ],

              Text(
                label,
                style: textTheme.labelSmall?.copyWith(
                  color: muted, 
                  fontSize: 14
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Text(
            value,
            style: textTheme.titleMedium?.copyWith(
              color: valueColor ?? colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}