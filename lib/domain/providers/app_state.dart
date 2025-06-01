import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    print('Theme toggled: isDarkMode = $_isDarkMode');
    notifyListeners();
  }
}
