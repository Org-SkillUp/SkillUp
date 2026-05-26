import 'package:flutter/material.dart';

String testeVar = "Conteudo teste";

class QuantityIndicator extends StatelessWidget {
  const QuantityIndicator({
    super.key,
    required this.value,
    this.size = 48,
  });

  final String value;
  final double size;

  @override
  Widget build(BuildContext context) {
    // TODO: aplicar cores dinâmicas com base no valor
    const baseColor = Color(0xFF48AD5B);

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: baseColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}