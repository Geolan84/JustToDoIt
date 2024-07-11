import 'package:elementary/elementary.dart';
import 'package:to_do/util/app_logger.dart';

/// Error handler with logging.
class TaskErrorHandler implements ErrorHandler {
  @override
  void handleError(
    Object error, {
    StackTrace? stackTrace,
  }) {
    AppLogger.logError(
      error.toString(),
      stackTrace.toString(),
    );
  }
}
