import 'package:SkillUp/core/theme/app_theme.dart';
import 'package:SkillUp/features/auth/guard/auth_guard.dart';
import 'package:SkillUp/features/auth/pages/forget_password_page.dart';
import 'package:SkillUp/features/auth/pages/login_page.dart';
import 'package:SkillUp/features/auth/pages/signup_page.dart';
import 'package:SkillUp/features/auth/routes/auth_routes.dart';
import 'package:SkillUp/features/conta/views/conta_page.dart';
import 'package:SkillUp/features/home/home_page.dart';
import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';
import 'package:SkillUp/features/tarefas/views/tarefa_create_page.dart';
import 'package:SkillUp/features/tarefas/views/tarefa_detail_page.dart';
import 'package:SkillUp/features/trilhas/views/trilhas_page.dart';
import 'package:SkillUp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GoogleSignIn.instance.initialize();

  runApp(const SkillUp());
}

class SkillUp extends StatelessWidget {
  const SkillUp({super.key});

  MaterialPageRoute _fallback(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => const LoginPage(),
      settings: settings,
    );
  }

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
      onGenerateRoute: (settings) {
        switch (settings.name) {

          case AuthRoutes.login:
            return MaterialPageRoute(
              builder: (_) => const LoginPage(),
              settings: settings,
            );

          case AuthRoutes.signup:
            return MaterialPageRoute(
              builder: (_) => const SignupPage(),
              settings: settings,
            );

          case AuthRoutes.forgotPassword:
            return MaterialPageRoute(
              builder: (_) => const ForgetPasswordPage(),
              settings: settings,
            );

          case AuthRoutes.home:
            final user = FirebaseAuth.instance.currentUser;
            return MaterialPageRoute(
              builder: (_) => AuthGuard(
                child: HomePage(userName: user?.displayName ?? 'Usuário'),
              ),
              settings: settings,
            );

          case AuthRoutes.trilhas:
            return MaterialPageRoute(
              builder: (_) => const AuthGuard(child: TrilhasPage()),
              settings: settings,
            );

          case AuthRoutes.conta:
            return MaterialPageRoute(
              builder: (_) => const AuthGuard(child: ContaPage()),
              settings: settings,
            );

          case AuthRoutes.tarefas:
            final tarefa = settings.arguments as TarefaDetail?;
            if (tarefa == null) return _fallback(settings);
            return MaterialPageRoute(
              builder: (_) => AuthGuard(
                child: TarefaDetailPage(tarefa: tarefa),
              ),
              settings: settings,
            );

          case AuthRoutes.criar:
            final trilhaId = settings.arguments as String?;
            return MaterialPageRoute(
              builder: (_) => AuthGuard(
                child: TarefaCreatePage(trilhaId: trilhaId),
              ),
              settings: settings,
            );

          default:
            return _fallback(settings);
        }
      },
    );
  }
}