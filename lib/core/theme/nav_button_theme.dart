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
      activeBackgroundColor:
          activeBackgroundColor ?? this.activeBackgroundColor,
      activeIconColor: activeIconColor ?? this.activeIconColor,
      activeTextColor: activeTextColor ?? this.activeTextColor,
      inactiveBackgroundColor:
          inactiveBackgroundColor ?? this.inactiveBackgroundColor,
      inactiveIconColor: inactiveIconColor ?? this.inactiveIconColor,
      inactiveTextColor: inactiveTextColor ?? this.inactiveTextColor,
    );
  }

  @override
  NavButtonTheme lerp(covariant ThemeExtension<NavButtonTheme>? other, double t) {
    if (other is! NavButtonTheme) return this;

    return NavButtonTheme(
      activeBackgroundColor: Color.lerp(
        activeBackgroundColor,
        other.activeBackgroundColor,
        t,
      )!,
      activeIconColor: Color.lerp(activeIconColor, other.activeIconColor, t)!,
      activeTextColor: Color.lerp(activeTextColor, other.activeTextColor, t)!,
      inactiveBackgroundColor: Color.lerp(
        inactiveBackgroundColor,
        other.inactiveBackgroundColor,
        t,
      )!,
      inactiveIconColor:
          Color.lerp(inactiveIconColor, other.inactiveIconColor, t)!,
      inactiveTextColor:
          Color.lerp(inactiveTextColor, other.inactiveTextColor, t)!,
    );
  }
}
