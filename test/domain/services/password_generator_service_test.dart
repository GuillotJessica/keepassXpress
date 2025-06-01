import 'package:flutter_test/flutter_test.dart';
import 'package:keepassxpress/domain/services/password_generator_service.dart';

void main() {
  late PasswordGeneratorService generator;

  setUp(() {
    generator = PasswordGeneratorService();
  });

  group('PasswordGeneratorService', () {
    test('generates password with default options', () {
      final password = generator.generatePassword(length: 16);
      expect(password.length, equals(16));
      expect(password, matches(RegExp(r'[A-Z]'))); // Contains uppercase
      expect(password, matches(RegExp(r'[a-z]'))); // Contains lowercase
      expect(password, matches(RegExp(r'[0-9]'))); // Contains numbers
      expect(
        password,
        matches(RegExp(r'[!@#$%^&*()_+\-=\[\]{}|;:,.<>?]')),
      ); // Contains special chars
    });

    test('generates password with custom options', () {
      final password = generator.generatePassword(
        length: 12,
        includeUppercase: false,
        includeNumbers: false,
        includeSpecialChars: false,
      );
      expect(password.length, equals(12));
      expect(password, matches(RegExp(r'^[a-z]+$'))); // Only lowercase letters
    });

    test('throws error for length less than 8', () {
      expect(() => generator.generatePassword(length: 7), throwsArgumentError);
    });

    test('calculates password strength correctly', () {
      expect(generator.calculatePasswordStrength('weak'), lessThan(0.3));
      expect(generator.calculatePasswordStrength('Weak123'), lessThan(0.6));
      expect(
        generator.calculatePasswordStrength('Strong123!'),
        greaterThan(0.6),
      );
      expect(
        generator.calculatePasswordStrength('VeryStrong123!@#'),
        greaterThan(0.8),
      );
    });

    test('excludes similar characters when requested', () {
      final password = generator.generatePassword(
        length: 32,
        excludeSimilarChars: true,
      );
      expect(password, isNot(contains('i')));
      expect(password, isNot(contains('l')));
      expect(password, isNot(contains('1')));
      expect(password, isNot(contains('o')));
      expect(password, isNot(contains('0')));
      expect(password, isNot(contains('O')));
    });

    test('excludes ambiguous characters when requested', () {
      final password = generator.generatePassword(
        length: 32,
        excludeAmbiguousChars: true,
      );
      expect(password, isNot(contains('{')));
      expect(password, isNot(contains('}')));
      expect(password, isNot(contains('[')));
      expect(password, isNot(contains(']')));
      expect(password, isNot(contains('(')));
      expect(password, isNot(contains(')')));
      expect(password, isNot(contains('/')));
      expect(password, isNot(contains('\\')));
      expect(password, isNot(contains('"')));
      expect(password, isNot(contains("'")));
      expect(password, isNot(contains('`')));
      expect(password, isNot(contains('~')));
      expect(password, isNot(contains(',')));
      expect(password, isNot(contains(';')));
      expect(password, isNot(contains(':')));
      expect(password, isNot(contains('.')));
    });
  });
}
