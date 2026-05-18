import 'package:SkillUp/core/theme/nav_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// TODO: Passar tamanhos para o tema

class NavButton extends StatelessWidget {
  const NavButton({
    super.key,
    required this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String iconPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final nav = Theme.of(context).extension<NavButtonTheme>()!;

    final backgroundColor = isSelected ? nav.activeBackgroundColor : nav.inactiveBackgroundColor;
    final iconColor = isSelected ? nav.activeIconColor : nav.inactiveIconColor;
    final textColor = isSelected ? nav.activeTextColor : nav.inactiveTextColor;

    return SizedBox(
      width: 80,
      height: 60,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}