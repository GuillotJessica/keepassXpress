import 'package:flutter_test/flutter_test.dart';
import 'package:keepassxpress/domain/providers/app_state.dart';

void main() {
  group('AppState Provider', () {
    test('Initial state is light mode', () {
      final appState = AppState();
      expect(appState.isDarkMode, isFalse);
    });

    test('toggleTheme switches between light and dark mode', () {
      final appState = AppState();
      appState.toggleTheme();
      expect(appState.isDarkMode, isTrue);
      appState.toggleTheme();
      expect(appState.isDarkMode, isFalse);
    });
  });
}
