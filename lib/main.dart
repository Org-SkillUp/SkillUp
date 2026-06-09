import 'package:SkillUp/core/theme/app_theme.dart';
import 'package:SkillUp/features/auth/pages/forget_password_page.dart';
import 'package:SkillUp/features/conta/views/conta_page.dart';
import 'package:SkillUp/features/trilhas/views/trilhas_page.dart';
import 'package:SkillUp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  await GoogleSignIn.instance.initialize();

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
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasData) {
            final user = snapshot.data!;
            return HomePage(
              userName: user.displayName ?? user.email ?? 'Usuário',
            );
          }

          return const LoginPage();
        },
      ),
      onGenerateRoute: (settings) {
        final routes = <String, WidgetBuilder>{
          AuthRoutes.login: (_) => const LoginPage(),
          AuthRoutes.signup: (_) => const SignupPage(),
          AuthRoutes.forgotPassword: (_) => const ForgetPasswordPage(),
          AuthRoutes.trilhas: (_) => const TrilhasPage(),
          AuthRoutes.conta: (_) => const ContaPage(),
          AuthRoutes.home: (_) {
            final user = FirebaseAuth.instance.currentUser;
            return HomePage(
              userName: user?.displayName ?? user?.email ?? 'Usuário',
            );
          },
          AuthRoutes.tarefas: (_) =>
              const TarefaDetailPage(tarefa: TarefaDetail.mock),
        };

        final builder = routes[settings.name];
        if (builder != null) {
          return MaterialPageRoute(
            builder: builder,
            settings: settings,
          );
        }

        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );
      },
    );
  }
}