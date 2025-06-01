import 'package:flutter_test/flutter_test.dart';
import 'package:keepassxpress/data/secure_storage_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SecureStorageService secureStorageService;

  setUp(() {
    secureStorageService = SecureStorageService();
  });

  group('SecureStorageService', () {
    const testKey = 'test_key';
    const testValue = 'test_value';

    test('write and read data', () async {
      // Write data
      await secureStorageService.writeSecureData(testKey, testValue);

      // Read data
      final readValue = await secureStorageService.readSecureData(testKey);

      // Verify
      expect(readValue, equals(testValue));
    });

    test('delete data', () async {
      // Write data
      await secureStorageService.writeSecureData(testKey, testValue);

      // Delete data
      await secureStorageService.deleteSecureData(testKey);

      // Try to read deleted data
      final readValue = await secureStorageService.readSecureData(testKey);

      // Verify
      expect(readValue, isNull);
    });
  });
}
