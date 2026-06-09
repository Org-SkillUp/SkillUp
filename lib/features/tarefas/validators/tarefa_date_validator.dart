import 'package:flutter/services.dart';

/// Valida e formata datas no padrão brasileiro DD/MM/AAAA.
abstract final class TarefaDateValidator {
  static const formatoHint = 'DD/MM/AAAA';
  static final _regex = RegExp(r'^(0[1-9]|[12]\d|3[01])/(0[1-9]|1[0-2])/\d{4}$');

  /// Aplica máscara numérica enquanto o usuário digita (ex.: 18042026 → 18/04/2026).
  static final inputFormatter = TextInputFormatter.withFunction((
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final buffer = StringBuffer();

    for (var i = 0; i < digits.length && i < 8; i++) {
      if (i == 2 || i == 4) buffer.write('/');
      buffer.write(digits[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  });

  /// Retorna mensagem de erro ou `null` quando o valor é válido.
  static String? validate(String value, {required String campo}) {
    final texto = value.trim();

    if (texto.isEmpty) {
      return 'Informe a data de $campo no formato $formatoHint.';
    }

    if (!_regex.hasMatch(texto)) {
      return 'A data de $campo deve estar no formato $formatoHint.';
    }

    final partes = texto.split('/');
    final dia = int.parse(partes[0]);
    final mes = int.parse(partes[1]);
    final ano = int.parse(partes[2]);

    final data = DateTime(ano, mes, dia);
    if (data.day != dia || data.month != mes || data.year != ano) {
      return 'A data de $campo é inválida.';
    }

    return null;
  }

  static DateTime? parse(String value) {
    if (validate(value, campo: 'data') != null) return null;

    final partes = value.trim().split('/');
    return DateTime(
      int.parse(partes[2]),
      int.parse(partes[1]),
      int.parse(partes[0]),
    );
  }
}
