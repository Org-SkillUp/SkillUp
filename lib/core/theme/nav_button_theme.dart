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
  NavButtonTheme copyWith({
    Color? activeBackgroundColor,
    Color? activeIconColor,
    Color? activeTextColor,
    Color? inactiveBackgroundColor,
    Color? inactiveIconColor,
    Color? inactiveTextColor,
  }) {
    return NavButtonTheme(
      activeBackgroundColor: activeBackgroundColor ?? this.activeBackgroundColor,
      activeIconColor: activeIconColor ?? this.activeIconColor,
      activeTextColor: activeTextColor ?? this.activeTextColor,
      inactiveBackgroundColor: inactiveBackgroundColor ?? this.inactiveBackgroundColor,
      inactiveIconColor: inactiveIconColor ?? this.inactiveIconColor,
      inactiveTextColor: inactiveTextColor ?? this.inactiveTextColor,
    );
  }
  
  @override
  ThemeExtension<NavButtonTheme> lerp(covariant ThemeExtension<NavButtonTheme>? other, double t) {
    // TODO: implement lerp
    throw UnimplementedError();
  }
}