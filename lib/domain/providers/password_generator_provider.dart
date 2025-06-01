import 'package:flutter/foundation.dart';
import 'package:keepassxpress/domain/services/password_generator_service.dart';

class PasswordGeneratorProvider extends ChangeNotifier {
  final PasswordGeneratorService _generator = PasswordGeneratorService();

  String _generatedPassword = '';
  int _passwordLength = 16;
  bool _includeUppercase = true;
  bool _includeNumbers = true;
  bool _includeSpecialChars = true;
  bool _excludeSimilarChars = true;
  bool _excludeAmbiguousChars = true;

  String get generatedPassword => _generatedPassword;
  int get passwordLength => _passwordLength;
  bool get includeUppercase => _includeUppercase;
  bool get includeNumbers => _includeNumbers;
  bool get includeSpecialChars => _includeSpecialChars;
  bool get excludeSimilarChars => _excludeSimilarChars;
  bool get excludeAmbiguousChars => _excludeAmbiguousChars;
  double get passwordStrength =>
      _generator.calculatePasswordStrength(_generatedPassword);

  void setPasswordLength(int length) {
    if (length < 8) length = 8;
    if (length > 128) length = 128;
    _passwordLength = length;
    notifyListeners();
  }

  void setIncludeUppercase(bool value) {
    _includeUppercase = value;
    notifyListeners();
  }

  void setIncludeNumbers(bool value) {
    _includeNumbers = value;
    notifyListeners();
  }

  void setIncludeSpecialChars(bool value) {
    _includeSpecialChars = value;
    notifyListeners();
  }

  void setExcludeSimilarChars(bool value) {
    _excludeSimilarChars = value;
    notifyListeners();
  }

  void setExcludeAmbiguousChars(bool value) {
    _excludeAmbiguousChars = value;
    notifyListeners();
  }

  void generatePassword() {
    _generatedPassword = _generator.generatePassword(
      length: _passwordLength,
      includeUppercase: _includeUppercase,
      includeNumbers: _includeNumbers,
      includeSpecialChars: _includeSpecialChars,
      excludeSimilarChars: _excludeSimilarChars,
      excludeAmbiguousChars: _excludeAmbiguousChars,
    );
    notifyListeners();
  }
}
