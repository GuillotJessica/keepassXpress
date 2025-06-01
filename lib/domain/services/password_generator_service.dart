import 'dart:math';

class PasswordGeneratorService {
  static const String _lowercaseChars = 'abcdefghijklmnopqrstuvwxyz';
  static const String _uppercaseChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const String _numbers = '0123456789';
  static const String _specialChars = '!@#\$%^&*()_+-=[]{}|;:,.<>?';

  String generatePassword({
    required int length,
    bool includeUppercase = true,
    bool includeNumbers = true,
    bool includeSpecialChars = true,
    bool excludeSimilarChars = true,
    bool excludeAmbiguousChars = true,
  }) {
    if (length < 8) {
      throw ArgumentError('Password length must be at least 8 characters');
    }

    String chars = _lowercaseChars;
    if (includeUppercase) chars += _uppercaseChars;
    if (includeNumbers) chars += _numbers;
    if (includeSpecialChars) chars += _specialChars;

    if (excludeSimilarChars) {
      chars = chars
          .replaceAll('i', '')
          .replaceAll('l', '')
          .replaceAll('1', '')
          .replaceAll('o', '')
          .replaceAll('0', '')
          .replaceAll('O', '');
    }

    if (excludeAmbiguousChars) {
      chars = chars
          .replaceAll('{', '')
          .replaceAll('}', '')
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll('(', '')
          .replaceAll(')', '')
          .replaceAll('/', '')
          .replaceAll('\\', '')
          .replaceAll('"', '')
          .replaceAll("'", '')
          .replaceAll('`', '')
          .replaceAll('~', '')
          .replaceAll(',', '')
          .replaceAll(';', '')
          .replaceAll(':', '')
          .replaceAll('.', '');
    }

    final random = Random.secure();
    final password = List.generate(
      length,
      (_) => chars[random.nextInt(chars.length)],
    ).join('');

    // Ensure password meets minimum requirements
    if (includeUppercase && !password.contains(RegExp(r'[A-Z]'))) {
      return generatePassword(
        length: length,
        includeUppercase: includeUppercase,
        includeNumbers: includeNumbers,
        includeSpecialChars: includeSpecialChars,
        excludeSimilarChars: excludeSimilarChars,
        excludeAmbiguousChars: excludeAmbiguousChars,
      );
    }

    if (includeNumbers && !password.contains(RegExp(r'[0-9]'))) {
      return generatePassword(
        length: length,
        includeUppercase: includeUppercase,
        includeNumbers: includeNumbers,
        includeSpecialChars: includeSpecialChars,
        excludeSimilarChars: excludeSimilarChars,
        excludeAmbiguousChars: excludeAmbiguousChars,
      );
    }

    if (includeSpecialChars &&
        !password.contains(RegExp(r'[!@#$%^&*()_+\-=\[\]{}|;:,.<>?]'))) {
      return generatePassword(
        length: length,
        includeUppercase: includeUppercase,
        includeNumbers: includeNumbers,
        includeSpecialChars: includeSpecialChars,
        excludeSimilarChars: excludeSimilarChars,
        excludeAmbiguousChars: excludeAmbiguousChars,
      );
    }

    return password;
  }

  double calculatePasswordStrength(String password) {
    double strength = 0.0;

    // Length contribution (up to 40% of total strength)
    strength += (password.length / 20) * 0.4;

    // Character variety contribution (up to 60% of total strength)
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.15;
    if (password.contains(RegExp(r'[a-z]'))) strength += 0.15;
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.15;
    if (password.contains(RegExp(r'[!@#$%^&*()_+\-=\[\]{}|;:,.<>?]')))
      strength += 0.15;

    return strength.clamp(0.0, 1.0);
  }
}
