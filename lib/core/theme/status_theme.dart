import 'package:flutter/material.dart';

class StatusTheme extends ThemeExtension<StatusTheme> {
  const StatusTheme({
    required this.activeColor,
    required this.pausedColor,
    required this.completedColor,
    required this.canceledColor,
    required this.pendingColor
  });

  final Color activeColor;
  final Color pausedColor;
  final Color completedColor;
  final Color canceledColor;
  final Color pendingColor;

  @override
  StatusTheme copyWith({
    Color? activeColor,
    Color? pausedColor,
    Color? completedColor,
    Color? canceledColor,
    Color? pendingColor
  }) {
    return StatusTheme(
      activeColor: activeColor ?? this.activeColor,
      pausedColor: pausedColor ?? this.pausedColor,
      completedColor: completedColor ?? this.completedColor,
      canceledColor: canceledColor ?? this.canceledColor,
      pendingColor: pendingColor ?? this.pendingColor,
    );
  }

  @override
  StatusTheme lerp(covariant ThemeExtension<StatusTheme>? other, double t) {
    if (other is! StatusTheme) return this;

    return StatusTheme(
      activeColor: Color.lerp(
        activeColor,
        other.activeColor,
        t,
      )!,
      pausedColor: Color.lerp(pausedColor, other.pausedColor, t)!,
      completedColor: Color.lerp(completedColor, other.completedColor, t)!,
      canceledColor: Color.lerp(
        canceledColor,
        other.canceledColor,
        t,
      )!,
      pendingColor: Color.lerp(
        pendingColor,
        other.pendingColor,
        t,
      )!,
    );
  }
}
