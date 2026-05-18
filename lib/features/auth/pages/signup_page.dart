import 'package:SkillUp/core/widgets/field_builder.dart';
import 'package:flutter/material.dart';
import '../routes/auth_routes.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF16212D);
    const fieldColor = Color(0xFF243652);
    const primaryColor = Color(0xFF6FAEB3);
    const textColor = Colors.white;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 360,
            margin: const EdgeInsets.symmetric(vertical: 24),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            color: backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AuthRoutes.login);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const SizedBox(height: 24),
                const Center(
                  child: Text(
                    'SKILLUP',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w300,
                      color: textColor,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                const Center(
                  child: Text(
                    'Criar Conta',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'NOME COMPLETO',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                TextFieldBuilder.buildTextField(
                  hint: 'Nome completo',
                  fillColor: fieldColor,
                ),
                const SizedBox(height: 14),
                const Text(
                  'EMAIL',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                TextFieldBuilder.buildTextField(
                  hint: 'Email',
                  fillColor: fieldColor,
                ),
                const SizedBox(height: 14),
                const Text(
                  'SENHA',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                TextFieldBuilder.buildTextField(
                  hint: 'Senha',
                  fillColor: fieldColor,
                  obscureText: true,
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'CRIAR',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AuthRoutes.login);
                    },
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        color: textColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}