import 'package:SkillUp/core/theme/card_item_theme.dart';
import 'package:SkillUp/features/trilhas/models/list_item.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.item});

  final ListItem item;

  @override
  Widget build(BuildContext context) {
    final cardItemTheme = Theme.of(context).extension<CardItemTheme>()!;

    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardItemTheme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: item.isSelected
                ? cardItemTheme.alternativeSideColor
                : cardItemTheme.defaultSideColor,
            width: 4,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.bold,
                    color: item.isSelected
                        ? cardItemTheme.labelColor.withAlpha((255/2).round())
                        : cardItemTheme.labelColor,
                    decoration:
                        item.isSelected ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Meta: ${item.subtitle}',
                  style: textTheme.labelSmall?.copyWith(
                    color: cardItemTheme.labelColor.withAlpha((255/2).round()),
                    fontSize: 12,
                    fontFamily: 'Arimo',
                  ),
                ),
                if (item.date != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined,
                          size: 12,
                          color: cardItemTheme.labelColor.withAlpha((255/2).round())),
                      const SizedBox(width: 6),
                      Text(
                        'Prazo: ${item.date}',
                        style: textTheme.labelSmall?.copyWith(
                          color: cardItemTheme.labelColor.withAlpha((255/2).round()),
                          fontFamily: 'Arimo',
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          Checkbox(
            value: item.isSelected,
            onChanged: (_) => item.onTap(item),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            activeColor: cardItemTheme.alternativeSideColor,
          ),
        ],
      ),
    );
  }
}