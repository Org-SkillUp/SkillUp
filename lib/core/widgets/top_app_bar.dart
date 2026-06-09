import 'package:SkillUp/features/auth/routes/auth_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({super.key});

  Future<void> _logout(BuildContext context) async {
    try {
      try {
        await GoogleSignIn.instance.disconnect();
      } catch (_) {}

      await FirebaseAuth.instance.signOut();

      if (!context.mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthRoutes.login,
        (route) => false,
      );
    } catch (_) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao sair da conta.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 64,
      title: const Text('SkillUp'),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => _logout(context),
          icon: SvgPicture.asset(
            'assets/icons/logout_icon.svg',
            width: 20,
            height: 20,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}