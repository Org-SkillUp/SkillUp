import 'package:SkillUp/core/theme/card_item_theme.dart';
import 'package:flutter/material.dart';

/// Campo de texto reutilizável dos formulários de tarefa.
///
/// Reaproveita o mesmo fundo e cantos arredondados dos cartões da tela de
/// detalhe ([TarefaInfoCard]/[TarefaDescriptionCard]) para que os modos de
/// edição e criação pareçam uma continuação natural da visualização.
class TarefaTextField extends StatelessWidget {
  const TarefaTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;

  /// Número de linhas do campo. Use um valor maior para campos longos,
  /// como a descrição da tarefa.
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final cardColor =
        Theme.of(context).extension<CardItemTheme>()!.backgroundColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withAlpha((255 * 0.6).round()),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 14, color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.white.withAlpha((255 * 0.4).round()),
            ),
            filled: true,
            fillColor: cardColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
