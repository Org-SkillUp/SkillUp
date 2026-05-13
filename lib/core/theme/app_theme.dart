import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData mainTheme = ThemeData(

    useMaterial3: true,

    colorScheme: ColorScheme.dark(
      surface: const Color.fromARGB(255, 38, 54, 76),
      primary: Colors.white,
    ),

    scaffoldBackgroundColor: const Color.fromARGB(255, 33, 40, 48),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 38, 54, 76),
      surfaceTintColor: Colors.transparent,
      foregroundColor: Colors.white,

      elevation: 0,
      scrolledUnderElevation: 2,

      centerTitle: false,
      leadingWidth: 240,
    ),
  );
}