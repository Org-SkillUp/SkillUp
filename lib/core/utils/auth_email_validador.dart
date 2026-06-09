class AuthEmailValidador {
  static const String allowedDomain = '@souunit.com.br';

  static bool isValidEmailFormat(String email) {
    final value = email.trim().toLowerCase();

    if (value.isEmpty) return false;

    final emailRegex = RegExp(
      r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$',
    );

    return emailRegex.hasMatch(value);
  }

  static bool isAllowedCompanyEmail(String email) {
    final value = email.trim().toLowerCase();
    return value.endsWith(allowedDomain);
  }
}