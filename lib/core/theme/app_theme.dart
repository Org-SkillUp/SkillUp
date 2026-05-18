import 'package:SkillUp/core/theme/nav_button_theme.dart';
import 'package:SkillUp/core/theme/state_button_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData mainTheme = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.dark(
      surface: const Color.fromARGB(255, 38, 54, 76),
      surfaceContainer: const Color.fromARGB(255, 52, 66, 86),
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

    // TODO: Adicionar estilos de textos

    extensions: const [
      NavButtonTheme(
        activeBackgroundColor: Color(0xFF415868),
        activeIconColor: Color(0xFF7FA7AA),
        activeTextColor: Color(0xFFFFFFFF),
        inactiveBackgroundColor: Colors.transparent,
        inactiveIconColor: Color(0xFF9F9F9F),
        inactiveTextColor: Color(0x99FFFFFF),
      ),
      StateButtonTheme(
        plainBackgroundColor: Color(0xFF5A969A),
        plainLabelColor: Color(0xFFFFFFFF),
        plainBorderColor: Colors.transparent,
        outlinedBackgroundColor: Color(0xFF2E3A48),
        outlinedYellowHighlighColor: Color(0xFFCFB680),
        outlinedGreenHighlighColor: Color(0xFF80CF99),
        outlinedRedHighlighColor: Color(0xFFCF8080),
      ),
    ],
  );
}