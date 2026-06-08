import 'package:SkillUp/core/theme/card_item_theme.dart';
import 'package:SkillUp/features/auth/routes/auth_routes.dart';
import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';
import 'package:SkillUp/features/trilhas/models/list.dart';
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

  final TarefaDetail item;
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

  @override
  Widget build(BuildContext context) {
    final cardItemTheme = Theme.of(context).extension<CardItemTheme>()!;

    final textTheme = Theme.of(context).textTheme;
    final isDimmed = item.dataConclusao != null && !disableSelectedStyle;
    final muted = cardItemTheme.labelColor.withAlpha((255 / 2).round());

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? cardItemTheme.backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border(
          left: BorderSide(
            color:
                sideColor ??
                (item.dataConclusao != null
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
                    onPressed: () => Navigator.pushReplacementNamed(
                      context,
                      AuthRoutes.tarefas,
                    ),
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      item.titulo,
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDimmed ? muted : cardItemTheme.labelColor,
                        decoration:
                            isDimmed ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 8),
                Text(
                  'Meta: ${item.metaRelacionada}',
                  style: textTheme.labelSmall?.copyWith(
                    color: cardItemTheme.labelColor.withAlpha((255/2).round()),
                    fontSize: 12,
                    fontFamily: 'Arimo',
                  ),
                ),
                if (showBottomDate && item.dataPrazo != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      if (showDateIcon) ...[
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 12,
                          color: cardItemTheme.labelColor.withAlpha((255/2).round())),
                        const SizedBox(width: 6),
                        Text(
                          'Prazo: ${item.dataPrazo?.toString() ?? "Sem prazo"}',
                          style: textTheme.labelSmall?.copyWith(
                            color: muted,
                            fontFamily: 'Arimo',
                          ),
                        ),
                        const SizedBox(width: 6),
                      ],
                      Text(
                        '$datePrefix${item.dataPrazo?.toString() ?? "Sem prazo"}',
                        style: textTheme.labelSmall?.copyWith(color: muted),
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
              value: item.dataConclusao != null,
              onChanged: (_) => /*item.onTap(item)*/ null,
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
