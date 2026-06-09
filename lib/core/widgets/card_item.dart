import 'package:SkillUp/core/theme/card_item_theme.dart';
import 'package:SkillUp/features/tarefas/models/list.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.item,
    this.backgroundColor,
    this.borderRadius = 12,
    this.datePrefix = 'Prazo: ',
    this.disableSelectedStyle = false,
    this.margin = const EdgeInsets.only(bottom: 12),
    this.padding = const EdgeInsets.all(16),
    this.showCheckbox = true,
    this.showDateIcon = true,
    this.showBottomDate = true,
    this.sideColor,
    this.sideWidth = 4,
    this.trailing,
  });

  final ListItem item;
  final Color? backgroundColor;
  final double borderRadius;
  final String datePrefix;
  final bool disableSelectedStyle;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final bool showCheckbox;
  final bool showDateIcon;
  final bool showBottomDate;
  final Color? sideColor;
  final double sideWidth;
  final Widget? trailing;

  String _formatDate(DateTime? date) {
    if (date == null) return 'Sem prazo';
    return '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/'
      '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final cardItemTheme = Theme.of(context).extension<CardItemTheme>()!;
    final textTheme = Theme.of(context).textTheme;
    final isDimmed = item.isSelected && !disableSelectedStyle;
    final muted = cardItemTheme.labelColor.withAlpha((255 / 2).round());

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? cardItemTheme.backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border(
          left: BorderSide(
            color: sideColor ??
              (item.isSelected
                ? cardItemTheme.alternativeSideColor
                : cardItemTheme.defaultSideColor),
            width: sideWidth,
          ),
        ),
      ),
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: item.onOpen,
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      item.title,
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDimmed ? muted : cardItemTheme.labelColor,
                        decoration: isDimmed ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                ),

                if (item.subtitle != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    item.subtitle!,
                    style: textTheme.labelSmall?.copyWith(
                      color: cardItemTheme.labelColor.withAlpha((255 / 2).round()),
                      fontSize: 12,
                      fontFamily: 'Arimo',
                    ),
                  ),
                ],

                if (showBottomDate) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      if (showDateIcon) ...[
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 12,
                          color: cardItemTheme.labelColor.withAlpha((255 / 2).round()),
                        ),
                        const SizedBox(width: 6),
                      ],
                      Text(
                        '$datePrefix${
                          item.date != null 
                          ? _formatDate(item.date)
                          : "Indefinido"
                        }',
                        style: textTheme.labelSmall?.copyWith(
                          color: muted,
                          fontFamily: 'Arimo',
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[const SizedBox(width: 10), trailing!],
          if (showCheckbox)
            Checkbox(
              value: item.isSelected,
              onChanged: (_) => item.onTap?.call(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              activeColor: cardItemTheme.alternativeSideColor,
            ),
        ],
      ),
    );
  }
}