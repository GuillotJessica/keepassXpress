import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:keepassxpress/domain/providers/app_state.dart';
import 'package:keepassxpress/domain/providers/password_generator_provider.dart';
import 'package:keepassxpress/presentation/screens/home_screen.dart';
import 'package:keepassxpress/presentation/screens/password_generator_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => PasswordGeneratorProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        final brightness = appState.isDarkMode
            ? Brightness.dark
            : Brightness.light;
        print('MyApp build: brightness = $brightness'); // Debug print
        return MaterialApp(
          title: 'KeePassXPress',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: brightness,
            ),
            useMaterial3: true,
            brightness: brightness,
          ),
          home: const HomeScreen(),
          routes: {
            '/password-generator': (context) => const PasswordGeneratorScreen(),
          },
        );
      },
    );
  }
}
