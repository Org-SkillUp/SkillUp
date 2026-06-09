import 'package:flutter/material.dart';

class WarningBanner extends StatelessWidget {
  final int tarefasHoje;

  const WarningBanner({
    super.key,
    required this.tarefasHoje,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF6E5A30),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.access_time,
            color: Color(0xFFE8B443),
          ),

          const SizedBox(width: 12),
          
          Text(
            "$tarefasHoje tarefa(s) vence(m) hoje", 
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}