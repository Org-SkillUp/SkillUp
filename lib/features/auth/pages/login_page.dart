import 'package:SkillUp/core/utils/auth_email_validador.dart';
import 'package:SkillUp/core/widgets/field_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../routes/auth_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    final email = _emailController.text.trim().toLowerCase();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage('Preencha email e senha.');
      return;
    }

    if (!AuthEmailValidador.isValidEmailFormat(email)) {
      _showMessage('Digite um email válido.');
      return;
    }

    if (!AuthEmailValidador.isAllowedCompanyEmail(email)) {
      _showMessage('Use apenas email @souunit.com.br');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AuthRoutes.home,
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        _showMessage('Email inválido.');
      } else if (e.code == 'invalid-credential') {
        _showMessage('Email ou senha incorretos.');
      } else if (e.code == 'user-not-found') {
        _showMessage('Usuário não encontrado.');
      } else if (e.code == 'wrong-password') {
        _showMessage('Senha incorreta.');
      } else if (e.code == 'too-many-requests') {
        _showMessage('Muitas tentativas. Tente novamente mais tarde.');
      } else {
        _showMessage('Erro ao fazer login: ${e.code}');
      }
    } catch (e) {
      _showMessage('Erro inesperado ao fazer login.');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                hint: 'E-mail',
                fillColor: fieldColor,
                controller: _emailController,
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
                controller: _passwordController,
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
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.4,
                          ),
                        )
                      : const Text(
                          'LOGIN',
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