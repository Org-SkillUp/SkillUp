import 'package:flutter/material.dart';

class CardItemTheme extends ThemeExtension<CardItemTheme> {
  const CardItemTheme({
    required this.defaultSideColor,
    required this.alternativeSideColor,
    required this.backgroundColor,
    required this.labelColor,
    required this.bodyColor,
  });

  final Color defaultSideColor;
  final Color alternativeSideColor;
  final Color backgroundColor;
  final Color labelColor;
  final Color bodyColor;

  @override
  CardItemTheme copyWith({
    Color? defaultSideColor,
    Color? alternativeSideColor,
    Color? backgroundColor,
    Color? labelColor,
    Color? bodyColor,
  }) {
    return CardItemTheme(
      defaultSideColor: defaultSideColor ?? this.defaultSideColor,
      alternativeSideColor:
          alternativeSideColor ?? this.alternativeSideColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      labelColor: labelColor ?? this.labelColor,
      bodyColor: bodyColor ?? this.bodyColor,
    );
  }

  @override
  CardItemTheme lerp(covariant ThemeExtension<CardItemTheme>? other, double t) {
    if (other is! CardItemTheme) return this;

    return CardItemTheme(
      defaultSideColor:
          Color.lerp(defaultSideColor, other.defaultSideColor, t)!,
      alternativeSideColor: Color.lerp(
        alternativeSideColor,
        other.alternativeSideColor,
        t,
      )!,
      backgroundColor:
          Color.lerp(backgroundColor, other.backgroundColor, t)!,
      labelColor: Color.lerp(labelColor, other.labelColor, t)!,
      bodyColor: Color.lerp(bodyColor, other.bodyColor, t)!,
    );
  }
}
