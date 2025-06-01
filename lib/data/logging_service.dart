import 'package:logging/logging.dart';

class LoggingService {
  final Logger _logger = Logger('KeePassXPress');

  LoggingService() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }

  void debug(String message) {
    _logger.fine(message);
  }

  void info(String message) {
    _logger.info(message);
  }

  void warning(String message) {
    _logger.warning(message);
  }

  void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.severe(message, error, stackTrace);
  }
}
