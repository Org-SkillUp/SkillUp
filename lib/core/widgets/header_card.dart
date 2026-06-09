import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {

  final String userName;

  const HomeHeader({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Text(
          "Olá, $userName!",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        const Text(
          "Continue progredindo. Você está indo muito bem!",
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}