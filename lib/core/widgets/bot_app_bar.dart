import 'package:SkillUp/core/widgets/nav_button.dart';
import 'package:flutter/material.dart';

class BotAppBar extends StatelessWidget {
  const BotAppBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        border: Border(
          top: BorderSide(
            color: Color(0x1AFFFFFF),
            width: 1,
          ),
        ),
        color: Color(0xFF26364C)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavButton(
            iconPath: "assets/icons/home_icon.svg",
            label: "Início",
            isSelected: selectedIndex == 0,
            onTap: () => onTabChanged(0),
          ),
          NavButton(
            iconPath: "assets/icons/goal_icon.svg",
            label: "Trilha",
            isSelected: selectedIndex == 1,
            onTap: () => onTabChanged(1),
          ),
          NavButton(
            iconPath: "assets/icons/profile_icon.svg",
            label: "Conta",
            isSelected: selectedIndex == 2,
            onTap: () => onTabChanged(2),
          ),
        ],
      ),
    );
  }
}