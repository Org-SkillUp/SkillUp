import 'package:flutter/material.dart';
import 'package:SkillUp/core/theme/app_theme.dart';
import 'package:SkillUp/views/trilhas_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Teste Tela",
      theme: AppTheme.mainTheme,
      home: const TrilhasPage(),
    );
  }
}
