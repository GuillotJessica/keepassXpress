import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:keepassxpress/domain/providers/password_generator_provider.dart';

class PasswordGeneratorScreen extends StatelessWidget {
  const PasswordGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Password Generator')),
      body: Consumer<PasswordGeneratorProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildPasswordDisplay(context, provider),
                const SizedBox(height: 24),
                _buildLengthSlider(provider),
                const SizedBox(height: 16),
                _buildOptionsList(provider),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: provider.generatePassword,
                  child: const Text('Generate Password'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPasswordDisplay(
    BuildContext context,
    PasswordGeneratorProvider provider,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              provider.generatedPassword.isEmpty
                  ? 'Click "Generate Password" to create a new password'
                  : provider.generatedPassword,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            if (provider.generatedPassword.isNotEmpty) ...[
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: provider.passwordStrength,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getStrengthColor(provider.passwordStrength),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Password Strength: ${_getStrengthLabel(provider.passwordStrength)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: provider.generatedPassword),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Password copied to clipboard'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLengthSlider(PasswordGeneratorProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password Length: ${provider.passwordLength}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Slider(
          value: provider.passwordLength.toDouble(),
          min: 8,
          max: 128,
          divisions: 120,
          label: provider.passwordLength.toString(),
          onChanged: (value) => provider.setPasswordLength(value.toInt()),
        ),
      ],
    );
  }

  Widget _buildOptionsList(PasswordGeneratorProvider provider) {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('Include Uppercase Letters'),
          value: provider.includeUppercase,
          onChanged: provider.setIncludeUppercase,
        ),
        SwitchListTile(
          title: const Text('Include Numbers'),
          value: provider.includeNumbers,
          onChanged: provider.setIncludeNumbers,
        ),
        SwitchListTile(
          title: const Text('Include Special Characters'),
          value: provider.includeSpecialChars,
          onChanged: provider.setIncludeSpecialChars,
        ),
        SwitchListTile(
          title: const Text('Exclude Similar Characters'),
          subtitle: const Text('e.g., i, l, 1, o, 0, O'),
          value: provider.excludeSimilarChars,
          onChanged: provider.setExcludeSimilarChars,
        ),
        SwitchListTile(
          title: const Text('Exclude Ambiguous Characters'),
          subtitle: const Text('e.g., { } [ ] ( ) / \\ " \' ` ~ , ; : .'),
          value: provider.excludeAmbiguousChars,
          onChanged: provider.setExcludeAmbiguousChars,
        ),
      ],
    );
  }

  Color _getStrengthColor(double strength) {
    if (strength < 0.3) return Colors.red;
    if (strength < 0.6) return Colors.orange;
    if (strength < 0.8) return Colors.yellow;
    return Colors.green;
  }

  String _getStrengthLabel(double strength) {
    if (strength < 0.3) return 'Weak';
    if (strength < 0.6) return 'Medium';
    if (strength < 0.8) return 'Strong';
    return 'Very Strong';
  }
}
