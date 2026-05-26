import 'package:flutter/material.dart';

class WarningBanner extends StatelessWidget {
  const WarningBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xFF7A6230),
        borderRadius: BorderRadius.circular(14),
      ),

      child: const Row(
        children: [

          Icon(
            Icons.access_time,
            color: Colors.amber,
          ),

          SizedBox(width: 12),

          Text(
            "1 tarefa vence hoje",
            style: TextStyle(
              color: Colors.white,
               fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}