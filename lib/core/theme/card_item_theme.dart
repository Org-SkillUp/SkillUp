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
    Color? sideColor,
    Color? backgroundColor,
    Color? labelColor,
    Color? bodyColor,
  }) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
  
  @override
  ThemeExtension<CardItemTheme> lerp(covariant ThemeExtension<CardItemTheme>? other, double t) {
    // TODO: implement lerp
    throw UnimplementedError();
  }
}