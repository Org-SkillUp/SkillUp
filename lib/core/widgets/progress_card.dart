import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: const Color(0xFF345645),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [

              const Text(
                "Progresso Geral",
                style: TextStyle(
                  color: Colors.white70,
                   fontSize: 14,
                ),
              ),

              Container(
                padding: const EdgeInsets.all(8),
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: const Icon(
                  Icons.trending_up,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          const Text(
            "60%",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),

            child: const LinearProgressIndicator(
              value: 0.6,
              minHeight: 8,
              backgroundColor: Colors.black26,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "3 de 5 trilhas concluídas",
            style: TextStyle(
              color: Colors.white70,
               fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}