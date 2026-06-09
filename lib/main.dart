import 'package:SkillUp/core/theme/app_theme.dart';
import 'package:SkillUp/features/auth/guard/auth_guard.dart';
import 'package:SkillUp/features/auth/pages/forget_password_page.dart';
import 'package:SkillUp/features/auth/pages/login_page.dart';
import 'package:SkillUp/features/auth/pages/signup_page.dart';
import 'package:SkillUp/features/auth/routes/auth_routes.dart';
import 'package:SkillUp/features/conta/views/conta_page.dart';
import 'package:SkillUp/features/home/home_page.dart';
import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';
import 'package:SkillUp/features/tarefas/views/tarefa_detail_page.dart';
import 'package:SkillUp/features/trilhas/views/trilhas_page.dart';
import 'package:SkillUp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
    return MaterialApp(
      title: 'SkillUp',
      theme: AppTheme.mainTheme,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasData) {
            final user = snapshot.data!;
            return HomePage(userName: user.displayName ?? 'Usuário');
          }

          return const LoginPage();
        },
      ),
      routes: {
        AuthRoutes.login: (_) => const LoginPage(),
        AuthRoutes.signup: (_) => const SignupPage(),
        AuthRoutes.forgotPassword: (_) => const ForgetPasswordPage(),
        AuthRoutes.home: (_) => AuthGuard(
          child: HomePage(
            userName: FirebaseAuth.instance.currentUser?.displayName ?? 'Usuário',
          ),
        ),
        AuthRoutes.trilhas: (_) => const AuthGuard(child: TrilhasPage()),
        AuthRoutes.conta: (_) => const AuthGuard(child: ContaPage()),
        AuthRoutes.tarefas: (_) => const AuthGuard(
          child: TarefaDetailPage(tarefa: TarefaDetail.mock),
        ),
      },
    );
  }
}