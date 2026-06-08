import 'package:SkillUp/core/widgets/nav_button.dart';
import 'package:SkillUp/features/auth/routes/auth_routes.dart';
import 'package:flutter/material.dart';

class BotAppBar extends StatelessWidget {
  const BotAppBar({
    super.key,
    required this.selectedPage,
  });

  final String selectedPage;

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
            isSelected: selectedPage == AuthRoutes.home,
            onPressed: () => Navigator.pushReplacementNamed(context, AuthRoutes.home),
          ),
          NavButton(
            iconPath: "assets/icons/goal_icon.svg",
            label: "Trilha",
            isSelected: selectedPage == AuthRoutes.trilhas,
            onPressed: () => Navigator.pushReplacementNamed(context, AuthRoutes.trilhas),
          ),
          NavButton(
            iconPath: "assets/icons/profile_icon.svg",
            label: "Conta",
            isSelected: selectedPage == AuthRoutes.conta,
            onPressed: () => Navigator.pushReplacementNamed(context, AuthRoutes.conta),
          ),
        ],
      ),
    );
  }
}