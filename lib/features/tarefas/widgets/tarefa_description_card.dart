import 'package:SkillUp/core/theme/card_item_theme.dart';
import 'package:flutter/material.dart';

class TarefaDescriptionCard extends StatelessWidget {
  const TarefaDescriptionCard({super.key, required this.descricao});

  final String descricao;

  @override
  Widget build(BuildContext context) {
    final cardColor =
        Theme.of(context).extension<CardItemTheme>()!.backgroundColor;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        descricao,
        style: TextStyle(
          fontSize: 14,
          height: 1.5,
          color: Colors.white.withAlpha((255 * 0.9).round()),
        ),
      ),
    );
  }
}
