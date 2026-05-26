import 'package:flutter/material.dart';

class TarefaInfoRow extends StatelessWidget {
  const TarefaInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha((255 * 0.6).round()),
            ) ,
          ) ,
          const SizedBox(height: 4),
          Text(
            value,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )
          ),
        ],
      ),
    );
  }
}
