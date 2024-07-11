import 'package:flutter/material.dart';

/// Button for task deleting.
class DeleteButton extends StatelessWidget {
  /// Callback to delete the task.
  final VoidCallback onTap;

  /// Title for button.
  final String title;

  /// Constructor of [DeleteButton].
  const DeleteButton({
    required this.onTap,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(
              Icons.delete,
              color: theme.colorScheme.error,
            ),
            Text(
              title,
              style: TextStyle(
                color: theme.colorScheme.error,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
