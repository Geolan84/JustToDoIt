import 'package:flutter/material.dart';

/// AppBar for single task view.
class TaskAppBar extends AppBar {
  /// Callback fir close action.
  final VoidCallback closeActionCallback;

  /// Callback for save action.
  final VoidCallback saveActionCallback;

  /// Title for 'save' button.
  final String saveActionTitle;

  /// Constructor of [TaskAppBar]
  TaskAppBar({
    required this.saveActionTitle,
    required this.saveActionCallback,
    required this.closeActionCallback,
    super.key,
  }) : super(
          leading: IconButton(
            onPressed: closeActionCallback,
            icon: const Icon(Icons.close),
          ),
          actions: [
            TextButton(
              onPressed: saveActionCallback,
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text(
                  saveActionTitle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        );
}
