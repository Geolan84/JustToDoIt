import 'package:flutter/material.dart';

/// Widget with error for entities loading.
class ErrorStateWidget extends StatelessWidget {
  /// Text with error.
  final String errorText;

  /// Text for reloading button.
  final String tryAgainText;

  /// Callback to retry.
  final VoidCallback retryCallback;

  /// Exception instanse.
  final Exception? exception;

  /// @nodoc
  const ErrorStateWidget({
    required this.errorText,
    required this.tryAgainText,
    required this.retryCallback,
    this.exception,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: FractionallySizedBox(
          widthFactor: 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                exception?.toString().replaceAll('Exception: ', '') ??
                    errorText,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(
                height: 5,
              ),
              OutlinedButton(
                child: Text(
                  tryAgainText,
                  overflow: TextOverflow.ellipsis,
                ),
                onPressed: retryCallback,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
