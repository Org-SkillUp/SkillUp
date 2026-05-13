import 'package:SkillUp/widgets/top_app_bar.dart';
import 'package:flutter/material.dart';

class TrilhasPage  extends StatelessWidget {
  const TrilhasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(),
      body: const Center(
        child: Text("Trilhas", style: TextStyle(fontSize: 24, color: Colors.white)),
      ),
    );
  }
  
}