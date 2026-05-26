import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.iconPath,
    this.iconColor,
    this.iconBackgroundColor,
    this.iconInValueRow = false,
    this.valueColor,
    this.dotColor,
    this.height,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 14,
    this.labelFontSize = 14,
    this.valueFontSize = 14,
  });

  final String label;
  final String value;
  final IconData? icon;
  final String? iconPath;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final bool iconInValueRow;
  final Color? valueColor;
  final Color? dotColor;
  final double? height;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double labelFontSize;
  final double valueFontSize;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final muted = colorScheme.primary.withAlpha(153);

    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _IndicatorLabel(
            dotColor: dotColor,
            icon: icon,
            iconPath: iconPath,
            iconColor: iconColor ?? muted,
            label: label,
            muted: muted,
            showIcon: !iconInValueRow,
            textTheme: textTheme,
            fontSize: labelFontSize,
          ),
          if (iconInValueRow) const Spacer() else const SizedBox(height: 8),

          if (iconInValueRow) ...[
            Row(
              children: [
                _IndicatorIcon(
                  icon: icon,
                  iconPath: iconPath,
                  color: iconColor ?? muted,
                  backgroundColor: iconBackgroundColor,
                  size: 18,
                ),
                const Spacer(),
                _IndicatorValue(
                  value: value,
                  valueColor: valueColor ?? colorScheme.primary,
                  textTheme: textTheme,
                  fontSize: valueFontSize,
                ),
              ],
            ),

            Text(
              label,
              style: textTheme.labelSmall?.copyWith(
                color: muted,
                fontFamily: 'Arimo',
                fontSize: 14,
              ),
            ),
          ] else
            _IndicatorValue(
              value: value,
              valueColor: valueColor ?? colorScheme.primary,
              textTheme: textTheme,
              fontSize: valueFontSize,
            ),

          const SizedBox(height: 8),
        ]
      ),
    );
  }
}

class _IndicatorLabel extends StatelessWidget {
  const _IndicatorLabel({
    required this.dotColor,
    required this.icon,
    required this.iconPath,
    required this.iconColor,
    required this.label,
    required this.muted,
    required this.showIcon,
    required this.textTheme,
    required this.fontSize,
  });

  final Color? dotColor;
  final IconData? icon;
  final String? iconPath;
  final Color iconColor;
  final String label;
  final Color muted;
  final bool showIcon;
  final TextTheme textTheme;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showIcon) ...[
          if (dotColor != null)
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            )
          else
            _IndicatorIcon(
              icon: icon,
              iconPath: iconPath,
              color: iconColor,
              backgroundColor: null,
              size: 12,
            ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelSmall?.copyWith(
              color: muted,
              fontSize: fontSize,
            ),
          ),
        ),
      ],
    );
  }
}

class _IndicatorIcon extends StatelessWidget {
  const _IndicatorIcon({
    required this.icon,
    required this.iconPath,
    required this.color,
    required this.backgroundColor,
    required this.size,
  });

  final IconData? icon;
  final String? iconPath;
  final Color color;
  final Color? backgroundColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    final iconWidget = iconPath == null
        ? Icon(icon, size: size, color: color)
        : SvgPicture.asset(
            iconPath!,
            width: size,
            height: size,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          );

    if (backgroundColor == null) {
      return iconWidget;
    }

    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: iconWidget,
    );
  }
}

class _IndicatorValue extends StatelessWidget {
  const _IndicatorValue({
    required this.value,
    required this.valueColor,
    required this.textTheme,
    required this.fontSize,
  });

  final String value;
  final Color valueColor;
  final TextTheme textTheme;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: textTheme.titleMedium?.copyWith(
        color: valueColor,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }
}
