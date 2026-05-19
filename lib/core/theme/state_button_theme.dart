import 'package:flutter/material.dart';

class StateButtonTheme extends ThemeExtension<StateButtonTheme> {
  const StateButtonTheme({
    required this.plainBackgroundColor,
    required this.plainLabelColor,
    required this.plainBorderColor,
    required this.outlinedBackgroundColor,
    required this.outlinedYellowHighlighColor,
    required this.outlinedGreenHighlighColor,
    required this.outlinedRedHighlighColor,
  });

  final Color plainBackgroundColor;
  final Color plainLabelColor;
  final Color plainBorderColor;

  final Color outlinedBackgroundColor;
  final Color outlinedYellowHighlighColor;
  final Color outlinedGreenHighlighColor;
  final Color outlinedRedHighlighColor;

  @override
  ThemeExtension<StateButtonTheme> lerp(covariant ThemeExtension<StateButtonTheme>? other, double t) {
    // TODO: implement lerp
    throw UnimplementedError();
  }
  
  @override
  ThemeExtension<StateButtonTheme> copyWith() {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}