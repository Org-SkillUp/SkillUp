import 'package:SkillUp/core/widgets/field_builder.dart';
import 'package:flutter/material.dart';
import '../routes/auth_routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    const fieldColor = Color(0xFF243652);
    const primaryColor = Color(0xFF6FAEB3);
    const textColor = Colors.white;
    const secondaryTextColor = Color(0xFFBFC7D1);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 32,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),

              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 240,
                  height: 90,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 48),

              const Text(
                'LOGIN',
                style: TextStyle(
                  color: textColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 8),

              TextFieldBuilder.buildTextField(
                hint: 'Email ou Usuário',
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

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AuthRoutes.forgotPassword);
                  },
                  child: const Text(
                    'Esqueceu a senha?',
                    style: TextStyle(color: secondaryTextColor, fontSize: 13),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AuthRoutes.signup);
                  },
                  child: const Text(
                    'Criar Conta',
                    style: TextStyle(
                      color: textColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
