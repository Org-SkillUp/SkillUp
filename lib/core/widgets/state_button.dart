import 'package:flutter/material.dart';

class StateButton extends StatelessWidget {
  const StateButton({
    super.key,
    required this.label,
    this.onPressed,
    this.bgColor = Colors.transparent,
    this.txtColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.borderWidth = 1.5,
    this.borderRadius = 14,
    this.icon,
  });

  final Text label;
  final VoidCallback? onPressed;
  final Color bgColor;
  final Color txtColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      foregroundColor: txtColor,
      elevation: 0,
      minimumSize: const Size(double.infinity, 52),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(color: borderColor, width: borderWidth),
      ),
    );

    if (icon != null) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        style: style,
        icon: icon!,
        label: label,
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: label,
    );
  }
}