import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do/core/domain/task/task.dart';
import 'package:to_do/util/extenstions/context_extension.dart';

/// Sliver widget with tasks.
class TasksList extends StatelessWidget {
  /// List of [Task] to show.
  final List<Task>? tasks;

  /// Callback to create new task.
  final VoidCallback newTaskCallback;

  /// Callback to complete the task.
  final Function(Task) onTaskCompleted;

  /// Callback to delete the task.
  final Function(Task) onTaskDeleted;

  /// Callback to open task editing form.
  final Function(Task) onTaskClicked;

  /// Constructor of [TasksList] widget.
  const TasksList({
    required this.tasks,
    required this.newTaskCallback,
    required this.onTaskCompleted,
    required this.onTaskDeleted,
    required this.onTaskClicked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(10),
      sliver: DecoratedSliver(
        decoration: BoxDecoration(
          color: context.colorScheme.secondary,
          borderRadius: BorderRadius.circular(15),
        ),
        sliver: SliverMainAxisGroup(
          slivers: [
            if (tasks != null)
              SliverConstrainedCrossAxis(
                maxExtent: 400,
                sliver: SliverList.builder(
                  itemCount: tasks?.length,
                  itemBuilder: (context, index) {
                    return _TaskItem(
                      task: tasks![index],
                      onTaskCompleted: onTaskCompleted,
                      onTaskDeleted: onTaskDeleted,
                      onTaskClicked: onTaskClicked,
                    );
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
                        context.l10n.newTask,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: context.colorScheme.onPrimary,
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

  final Function(Task) onTaskCompleted;

  final Function(Task) onTaskDeleted;

  final Function(Task) onTaskClicked;

  const _TaskItem({
    required this.task,
    required this.onTaskCompleted,
    required this.onTaskDeleted,
    required this.onTaskClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('${task.id} ${task.isDone}'),
      background: _DismissibleDecoration(
        alignment: Alignment.centerLeft,
        backgroundColor: context.colorScheme.onSecondary,
        foregroundColor: context.colorScheme.secondary,
        icon: Icons.check,
      ),
      secondaryBackground: _DismissibleDecoration(
        alignment: Alignment.centerRight,
        backgroundColor: context.colorScheme.error,
        foregroundColor: context.colorScheme.secondary,
        icon: Icons.delete,
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          onTaskCompleted(task);
        } else {
          onTaskDeleted(task);
        }
      },
      child: GestureDetector(
        onTap: () => onTaskClicked(task),
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
                      task.text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        decoration:
                            task.isDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    if (task.deadline != null)
                      Text(
                        DateFormat('dd.MM.yyyy').format(
                            DateTime.fromMicrosecondsSinceEpoch(
                                task.deadline!)),
                        style: TextStyle(color: context.colorScheme.onPrimary),
                      )
                  ],
                ),
              ),
              if (task.importance == Importance.important)
                Icon(
                  Icons.error_outline,
                  color: context.colorScheme.error,
                )
              else if (task.importance == Importance.low)
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
