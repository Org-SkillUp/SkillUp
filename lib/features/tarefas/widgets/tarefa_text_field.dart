import 'package:SkillUp/core/theme/card_item_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.keyboardType,
    this.inputFormatters,
    this.errorText,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;

  /// Número de linhas do campo. Use um valor maior para campos longos,
  /// como a descrição da tarefa.
  final int maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;

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
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: const TextStyle(fontSize: 14, color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.white.withAlpha((255 * 0.4).round()),
            ),
            errorText: errorText,
            errorStyle: const TextStyle(
              color: Color(0xFFCF8080),
              fontSize: 12,
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
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: errorText != null
                  ? const BorderSide(color: Color(0xFFCF8080))
                  : BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: errorText != null
                    ? const Color(0xFFCF8080)
                    : Colors.white.withAlpha((255 * 0.3).round()),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFCF8080)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFCF8080)),
            ),
          ),
        ),
      ],
    );
  }
}
