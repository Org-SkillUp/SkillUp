import 'package:flutter/material.dart';

class StateButtonTheme extends ThemeExtension<StateButtonTheme> {
  const StateButtonTheme({
    required this.createBackgroundColor,
    required this.plainBackgroundColor,
    required this.plainLabelColor,
    required this.plainBorderColor,
    required this.outlinedBackgroundColor,
    required this.outlinedYellowHighlighColor,
    required this.outlinedGreenHighlighColor,
    required this.outlinedRedHighlighColor,
  });
  final Color createBackgroundColor;
  final Color plainBackgroundColor;
  final Color plainLabelColor;
  final Color plainBorderColor;

  final Color outlinedBackgroundColor;
  final Color outlinedYellowHighlighColor;
  final Color outlinedGreenHighlighColor;
  final Color outlinedRedHighlighColor;

  @override
  StateButtonTheme copyWith({
    Color? createBackgroundColor,
    Color? plainBackgroundColor,
    Color? plainLabelColor,
    Color? plainBorderColor,
    Color? outlinedBackgroundColor,
    Color? outlinedYellowHighlighColor,
    Color? outlinedGreenHighlighColor,
    Color? outlinedRedHighlighColor,
  }) {
    return StateButtonTheme(
      createBackgroundColor: createBackgroundColor ?? this.createBackgroundColor,
      plainBackgroundColor: plainBackgroundColor ?? this.plainBackgroundColor,
      plainLabelColor: plainLabelColor ?? this.plainLabelColor,
      plainBorderColor: plainBorderColor ?? this.plainBorderColor,
      outlinedBackgroundColor: outlinedBackgroundColor ?? this.outlinedBackgroundColor,
      outlinedYellowHighlighColor: outlinedYellowHighlighColor ?? this.outlinedYellowHighlighColor,
      outlinedGreenHighlighColor: outlinedGreenHighlighColor ?? this.outlinedGreenHighlighColor,
      outlinedRedHighlighColor: outlinedRedHighlighColor ?? this.outlinedRedHighlighColor,
    );
  }

  @override
  StateButtonTheme lerp(covariant ThemeExtension<StateButtonTheme>? other, double t) {
    if (other is! StateButtonTheme) return this;

    return StateButtonTheme(
      createBackgroundColor: Color.lerp(createBackgroundColor, other.createBackgroundColor, t)!,
      plainBackgroundColor: Color.lerp(
        plainBackgroundColor,
        other.plainBackgroundColor,
        t,
      )!,
      plainLabelColor: Color.lerp(plainLabelColor, other.plainLabelColor, t)!,
      plainBorderColor: Color.lerp(plainBorderColor, other.plainBorderColor, t)!,
      outlinedBackgroundColor: Color.lerp(
        outlinedBackgroundColor,
        other.outlinedBackgroundColor,
        t,
      )!,
      outlinedYellowHighlighColor: Color.lerp(
        outlinedYellowHighlighColor,
        other.outlinedYellowHighlighColor,
        t,
      )!,
      outlinedGreenHighlighColor: Color.lerp(
        outlinedGreenHighlighColor,
        other.outlinedGreenHighlighColor,
        t,
      )!,
      outlinedRedHighlighColor: Color.lerp(
        outlinedRedHighlighColor,
        other.outlinedRedHighlighColor,
        t,
      )!,
    );
  }
}
