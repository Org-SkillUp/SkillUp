import 'package:SkillUp/core/theme/app_theme.dart';
import 'package:SkillUp/features/auth/pages/forget_password_page.dart';
import 'package:SkillUp/features/conta/views/conta_page.dart';
import 'package:SkillUp/features/trilhas/views/trilhas_page.dart';
import 'package:flutter/material.dart';
import 'features/auth/pages/login_page.dart';
import 'features/auth/pages/signup_page.dart';
import 'features/home/home_page.dart';
import 'features/auth/routes/auth_routes.dart';
import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';
import 'package:SkillUp/features/tarefas/views/tarefa_detail_page.dart';

void main() {
  runApp(const SkillUp());
}

class SkillUp extends StatelessWidget {
  const SkillUp({super.key});

  bool get _isLoggedIn => true; // TODO: Implementar lógica de autenticação real

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkillUp',
      theme: AppTheme.mainTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AuthRoutes.login,
      onGenerateRoute: (settings) {
        const protectedRoutes = [AuthRoutes.trilhas, AuthRoutes.conta];

        if (protectedRoutes.contains(settings.name) && !_isLoggedIn) {
          return MaterialPageRoute(
            builder: (_) => const LoginPage(),
            settings: settings,
          );
        }

        final routes = {
          AuthRoutes.login: (_) => const LoginPage(),
          AuthRoutes.signup: (_) => const SignupPage(),
          AuthRoutes.forgotPassword: (_) => const ForgetPasswordPage(),
          AuthRoutes.trilhas: (_) => const TrilhasPage(),
          AuthRoutes.conta: (_) => const ContaPage(),
          '/home': (_) => const HomePage(
            userName: "Guylherme"
          ),
          AuthRoutes.tarefas: (_) => const TarefaDetailPage(tarefa: TarefaDetail.mock),
        };

        final builder = routes[settings.name];
        if (builder != null) {
          return MaterialPageRoute(builder: builder, settings: settings);
        }

        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );
      },
    );
  }
}
