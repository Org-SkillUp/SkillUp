import 'package:SkillUp/core/theme/app_theme.dart';
import 'package:SkillUp/features/trilhas/views/trilhas_page.dart';
import 'package:flutter/material.dart';
import 'features/auth/pages/login_page.dart';
import 'features/auth/pages/signup_page.dart';
import 'features/auth/routes/auth_routes.dart';

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
        const protectedRoutes = [
          AuthRoutes.trilhas,
        ];

        if (protectedRoutes.contains(settings.name) && !_isLoggedIn) {
          return MaterialPageRoute(builder: (_) => const LoginPage(), settings: settings);
        }

        final routes = {
          AuthRoutes.login: (_) => const LoginPage(),
          AuthRoutes.signup: (_) => const SignupPage(),
          AuthRoutes.forgotPassword: (_) => const ForgotPasswordPlaceholderPage(),
          AuthRoutes.trilhas: (_) => const TrilhasPage(),
        };

        final builder = routes[settings.name];
        if (builder != null) {
          return MaterialPageRoute(builder: builder, settings: settings);
        }

        return MaterialPageRoute(builder: (_) => const LoginPage(), settings: settings);
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