import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final int trilhasConcluidas;
  final int totalTrilhas;

  const ProgressCard({
    super.key,
    required this.trilhasConcluidas,
    required this.totalTrilhas,
  });

  @override
  Widget build(BuildContext context) {
    //Calculamos o progresso 
    final double progresso = totalTrilhas > 0 ? trilhasConcluidas / totalTrilhas : 0.0;
    final int porcentagem = (progresso * 100).toInt();

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Progresso Geral",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  // Exibe a porcentagem 
                  Text(
                    "$porcentagem%",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              // Atribui o valor do progresso 
              value: progresso,
              minHeight: 8,
              color: const Color(0xFF4BA759),
              backgroundColor: Colors.black26,
            ),
          ),
          const SizedBox(height: 8),
          //Texto descritivo 
          Text(
            "$trilhasConcluidas de $totalTrilhas trilhas concluídas",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}