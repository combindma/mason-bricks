import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(),
    level: Level.debug,
  );

  static void debug(String message) {
    _logger.d(message);
  }

  static void info(String message) {
    _logger.i(message);
  }

  static void warning(String message) {
    _logger.w(message);
  }

  static void error({String message = 'An error occurred', dynamic error}) {
    _logger.e('An error occurred', error: error,  stackTrace: StackTrace.current);
  }
}

/*
*  Examples of Logging in Action
* AppLogger.debug('App started successfully');
* AppLogger.info('User logged in with ID: $id');
* AppLogger.warning('API response took longer than expected');
* AppLogger.error(e);
* AppLogger.error('Failed to fetch data', e);
* */