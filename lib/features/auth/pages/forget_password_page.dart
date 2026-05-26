import 'package:flutter/material.dart';
import '../routes/auth_routes.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  // Controllers
  late TextEditingController _emailController;
  
  // Estado
  bool _isLoading = false;
  bool _isSuccess = false;
  String? _emailError;
  
  // Constantes de design
  static const Color _fieldColor = Color(0xFF243652);
  static const Color _primaryColor = Color(0xFF6FAEB3);
  static const Color _textColor = Colors.white;
  static const Color _errorColor = Color(0xFFE63946);
  
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  /// Valida o formato do email
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Simula o envio do link de recuperação
  Future<void> _handleSendRecoveryLink() async {
    final email = _emailController.text.trim();

    // Validação
    if (email.isEmpty) {
      setState(() {
        _emailError = 'Email é obrigatório';
      });
      return;
    }

    if (!_isValidEmail(email)) {
      setState(() {
        _emailError = 'Email inválido';
      });
      return;
    }

    // Limpar erro se validação passou
    setState(() {
      _emailError = null;
      _isLoading = true;
    });

    // Simular delay de rede (2 segundos)
    await Future.delayed(const Duration(seconds: 2));

    // Simular sucesso
    setState(() {
      _isLoading = false;
      _isSuccess = true;
    });

    // Aguardar 2 segundos antes de voltar
    await Future.delayed(const Duration(seconds: 2));

    // Voltar para login
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  /// Constrói um campo de texto estilizado
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
    String? errorText,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          style: const TextStyle(
            color: _textColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: _textColor.withOpacity(0.5),
              fontSize: 14,
            ),
            filled: true,
            fillColor: _fieldColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: _primaryColor,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: _errorColor,
                width: 1.5,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 8),
          Text(
            errorText,
            style: const TextStyle(
              color: _errorColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }

  /// Constrói o conteúdo do botão com estados (idle, loading, success)
  Widget _buildButtonContent() {
    if (_isSuccess) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.check_circle, color: _textColor, size: 20),
          SizedBox(width: 8),
          Text(
            'Email Enviado!',
            style: TextStyle(
              color: _textColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }

    if (_isLoading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                _textColor.withOpacity(0.8),
              ),
              strokeWidth: 2,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Enviando...',
            style: TextStyle(
              color: _textColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }

    return const Text(
      'Enviar Link de Recuperação',
      style: TextStyle(
        color: _textColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.only(right: 150),
          icon: const Icon(Icons.arrow_back, color: _textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: 360,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                
              Image.asset(
              'assets/images/logo.png',
              width: 240,     // ✅ CORRETO
              height: 90,
              fit: BoxFit.contain,
            ),
                const SizedBox(height: 48),

                // Título
                const Text(
                  'ESQUECER SENHA',
                  style: TextStyle(
                    color: _textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),

                // Subtítulo
                Text(
                  'Digite seu email para receber um link de recuperação',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _textColor.withOpacity(0.7),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 32),

                // Campo de Email
                _buildTextField(
                  controller: _emailController,
                  hint: 'Email',
                  errorText: _emailError,
                  onChanged: (value) {
                    if (_emailError != null) {
                      setState(() {
                        _emailError = null;
                      });
                    }
                  },
                ),
                const SizedBox(height: 24),

                // Botão Enviar Link
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isLoading || _isSuccess
                        ? null
                        : _handleSendRecoveryLink,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      disabledBackgroundColor: _primaryColor.withOpacity(0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2,
                    ),
                    child: _buildButtonContent(),
                  ),
                ),
                const SizedBox(height: 16),

                // Link Voltar para Login
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Voltar para o Login',
                    style: TextStyle(
                      color: _primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}