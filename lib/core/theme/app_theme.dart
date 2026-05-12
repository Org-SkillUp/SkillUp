import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),

    appBarTheme: const AppBarTheme(centerTitle: true),
  );
}
