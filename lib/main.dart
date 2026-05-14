import 'package:flutter/material.dart';
import 'features/auth/pages/login_page.dart';
import 'features/auth/pages/signup_page.dart';
import 'features/auth/routes/auth_routes.dart';

void main() {
  runApp(const SkillUp());
}

class SkillUp extends StatelessWidget {
  const SkillUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AuthRoutes.login,
      routes: {
        AuthRoutes.login: (_) => const LoginPage(),
        AuthRoutes.signup: (_) => const SignupPage(),
        AuthRoutes.forgotPassword: (_) => const ForgotPasswordPlaceholderPage(),
      },
    );
  }
}

class ForgotPasswordPlaceholderPage extends StatelessWidget {
  const ForgotPasswordPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar senha')),
      body: const Center(
        child: Text('Tela reservada para recuperação de senha.'),
      ),
    );
  }
}