import 'package:SkillUp/core/theme/app_theme.dart';
import 'package:SkillUp/features/auth/pages/forget_password_page.dart';
import 'package:SkillUp/features/conta/views/conta_page.dart';
import 'package:SkillUp/features/trilhas/views/trilhas_page.dart';
import 'package:SkillUp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'features/auth/pages/login_page.dart';
import 'features/auth/pages/signup_page.dart';
import 'features/auth/routes/auth_routes.dart';
import 'features/home/home_page.dart';
import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';
import 'package:SkillUp/features/tarefas/views/tarefa_detail_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SkillUp());
}

class SkillUp extends StatelessWidget {
  const SkillUp({super.key});

  @override
  Widget build(BuildContext context) {
    final isLogged = FirebaseAuth.instance.currentUser != null;

    return MaterialApp(
      title: 'SkillUp',
      theme: AppTheme.mainTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: isLogged ? AuthRoutes.home : AuthRoutes.login,
      routes: {
        AuthRoutes.login: (_) => const LoginPage(),
        AuthRoutes.signup: (_) => const SignupPage(),
        AuthRoutes.forgotPassword: (_) => const ForgetPasswordPage(),
        AuthRoutes.trilhas: (_) => const TrilhasPage(),
        AuthRoutes.conta: (_) => const ContaPage(),
        AuthRoutes.home: (_) {
          final user = FirebaseAuth.instance.currentUser;
          return HomePage(userName: user?.email ?? 'Usuário');
        },
        AuthRoutes.tarefas: (_) =>
            const TarefaDetailPage(tarefa: TarefaDetail.mock),
      },
    );
  }
}