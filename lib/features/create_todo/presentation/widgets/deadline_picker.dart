import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do/util/extenstions/context_extension.dart';

/// Date picker for the task's deadline.
class DeadlinePicker extends StatelessWidget {
  /// Listenable state for current deadline value.
  final ValueListenable<int?> deadline;

  /// Callback to change selected deadline.
  final Function(DateTime?) onDeadlineChanged;

  /// Constructor of [DeadlinePicker].
  const DeadlinePicker({
    required this.deadline,
    required this.onDeadlineChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: deadline,
      builder: (_, currentDeadline, __) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.deadlineHeader,
                overflow: TextOverflow.ellipsis,
              ),
              if (currentDeadline != null)
                Text(
                  DateFormat('d MMMM').format(
                    DateTime.fromMicrosecondsSinceEpoch(currentDeadline),
                  ),
                  style: TextStyle(
                    color: context.colorScheme.primary,
                  ),
                  overflow: TextOverflow.ellipsis,
                )
            ],
          ),
          Switch.adaptive(
            value: currentDeadline != null,
            onChanged: (isActive) async {
              if (isActive) {
                final now = DateTime.now();
                final picked = await showDatePicker(
                  context: context,
                  initialDate: now,
                  firstDate: now,
                  lastDate: DateTime(2200),
                );
                onDeadlineChanged(picked);
              } else {
                onDeadlineChanged(null);
              }
            },
          )
        ],
      ),
    );
  }
}
