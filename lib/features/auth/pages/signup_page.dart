import 'package:SkillUp/core/utils/auth_email_validador.dart';
import 'package:SkillUp/core/widgets/field_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../routes/auth_routes.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signup() async {
    final email = _emailController.text.trim().toLowerCase();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showMessage('Preencha todos os campos.');
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

    if (password.length < 6) {
      _showMessage('A senha deve ter pelo menos 6 caracteres.');
      return;
    }

    if (password != confirmPassword) {
      _showMessage('As senhas não coincidem.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseAuth.instance.signOut();

      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Conta criada com sucesso! Faça login para continuar.'),
            behavior: SnackBarBehavior.floating,
          ),
        );

        Navigator.pushNamedAndRemoveUntil(
          context,
          AuthRoutes.login,
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showMessage('Senha fraca.');
      } else if (e.code == 'email-already-in-use') {
        _showMessage('Este email já está em uso.');
      } else if (e.code == 'invalid-email') {
        _showMessage('Email inválido.');
      } else {
        _showMessage('Erro ao cadastrar: ${e.code}');
      }
    } catch (e) {
      _showMessage('Erro inesperado ao cadastrar.');
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
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const fieldColor = Color(0xFF243652);
    const primaryColor = Color(0xFF6FAEB3);
    const textColor = Colors.white;

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
                'CRIAR CONTA',
                style: TextStyle(
                  color: textColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              TextFieldBuilder.buildTextField(
                hint: 'Insira seu email',
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
              const SizedBox(height: 14),
              const Text(
                'CONFIRMAR SENHA',
                style: TextStyle(
                  color: textColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              TextFieldBuilder.buildTextField(
                hint: 'Confirmar senha',
                fillColor: fieldColor,
                obscureText: true,
                controller: _confirmPasswordController,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signup,
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
                          'CADASTRAR',
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
                    Navigator.pushReplacementNamed(
                      context,
                      AuthRoutes.login,
                    );
                  },
                  child: const Text(
                    'Já tenho conta',
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