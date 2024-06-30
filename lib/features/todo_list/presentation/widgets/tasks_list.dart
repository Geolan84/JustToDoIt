import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:to_do/core/domain/task/task.dart';
import 'package:to_do/features/create_todo/presentation/single_todo_screen.dart';

/// Sliver widget with tasks.
class TasksList extends StatelessWidget {
  /// List of [Task] to show.
  final List<Task> tasks;

  /// Callback to create new task.
  final VoidCallback? newTaskCallback;

  /// Constructor of [TasksList] widget.
  const TasksList({
    required this.tasks,
    this.newTaskCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return SliverPadding(
      padding: const EdgeInsets.all(10),
      sliver: DecoratedSliver(
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(15),
        ),
        sliver: SliverMainAxisGroup(
          slivers: [
            SliverConstrainedCrossAxis(
              maxExtent: 400,
              sliver: SliverList.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return _TaskItem(task: tasks[index]);
                },
              ),
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: newTaskCallback,
                child: Container(
                  height: 50,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        l10n.newTask,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  final Task task;

  const _TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dismissible(
      key: Key(task.title),
      background: _DismissibleDecoration(
        alignment: Alignment.centerLeft,
        backgroundColor: theme.colorScheme.onSecondary,
        foregroundColor: theme.colorScheme.secondary,
        icon: Icons.check,
      ),
      secondaryBackground: _DismissibleDecoration(
        alignment: Alignment.centerRight,
        backgroundColor: theme.colorScheme.error,
        foregroundColor: theme.colorScheme.secondary,
        icon: Icons.delete,
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
        } else {}
      },
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SingleToDoScreen(task: task),
          ),
        ),
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.only(
            top: 5,
            right: 12,
          ),
          child: Row(
            children: [
              Checkbox.adaptive(
                onChanged: (newValue) {
                  if (newValue != null && newValue) {}
                },
                value: false,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16),
                    ),
                    if (task.date != null)
                      Text(
                        DateFormat('dd.MM.yyyy').format(task.date!),
                        style: TextStyle(color: theme.colorScheme.onPrimary),
                      )
                  ],
                ),
              ),
              if (task.priority == Priority.high)
                const Icon(Icons.error_outline, color: Colors.red)
              else if (task.priority == Priority.low)
                const Icon(Icons.arrow_downward)
            ],
          ),
        ),
      ),
    );
  }
}

class _DismissibleDecoration extends StatelessWidget {
  final Color backgroundColor;

  final Color foregroundColor;

  final IconData icon;

  final Alignment alignment;

  const _DismissibleDecoration({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.alignment,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: backgroundColor,
      ),
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Icon(
            icon,
            color: foregroundColor,
          ),
        ),
      ),
    );
  }
}
