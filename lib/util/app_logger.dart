import 'package:logger/logger.dart';

/// Logger for app.
class AppLogger {
  static final _logger = Logger();

  /// Creates log with completed task.
  static void logCompletedTask(String taskDetails) {
    _logger.d('Task <$taskDetails> is completed.');
  }

  /// Creates log with deleted task.
  static void logDeletedTask(String taskDetails) {
    _logger.d('Task <$taskDetails> is deleted.');
  }

  /// Creates log with error message.
  static void logError(String errorMessage, String? stackTrace) {
    _logger.e(
      'Error: $errorMessage\nStackTrace:${stackTrace ?? '-'}',
    );
  }
}
