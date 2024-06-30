import 'package:logger/logger.dart';

/// Logger for app.
class AppLogger {
  final _logger = Logger();

  /// Creates log with completed task.
  void logCompletedTask(String taskDetails) {
    _logger.d('Task <$taskDetails> is completed.');
  }

  /// Creates log with deleted task.
  void logDeletedTask(String taskDetails) {
    _logger.d('Task <$taskDetails> is deleted.');
  }
}
