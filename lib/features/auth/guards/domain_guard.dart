class DomainGuard {
  DomainGuard._();

  static const String allowedDomain = '@souunit.com.br';

  static bool isAllowedEmail(String email) {
    return email.trim().toLowerCase().endsWith(allowedDomain);
  }

  static String? validateInstitutionalEmail(String? value) {
    final email = value?.trim().toLowerCase() ?? '';

    if (email.isEmpty) {
      return 'Informe seu e-mail.';
    }

    if (!email.contains('@')) {
      return 'Informe um e-mail válido.';
    }

    if (!email.endsWith(allowedDomain)) {
      return 'Use seu e-mail institucional ${allowedDomain.replaceFirst('@', '')}.';
    }

    return null;
  }
}
