import 'package:flutter/material.dart';

class NavButtonTheme extends ThemeExtension<NavButtonTheme> {
  const NavButtonTheme({
    required this.activeBackgroundColor,
    required this.activeIconColor,
    required this.activeTextColor,
    required this.inactiveBackgroundColor,
    required this.inactiveIconColor,
    required this.inactiveTextColor,
  });

  final Color activeBackgroundColor;
  final Color activeIconColor;
  final Color activeTextColor;
  final Color inactiveBackgroundColor;
  final Color inactiveIconColor;
  final Color inactiveTextColor;

  @override
  ThemeExtension<NavButtonTheme> lerp(covariant ThemeExtension<NavButtonTheme>? other, double t) {
    // TODO: implement lerp
    throw UnimplementedError();
  }
  
  @override
  ThemeExtension<NavButtonTheme> copyWith() {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}