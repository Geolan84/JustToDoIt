import 'package:to_do/core/domain/task/task.dart';

/// Class for storing tasks with current revision.
class TaskResponse {
  /// Constructor for task response.
  const TaskResponse({
    required this.tasks,
    required this.revision,
  });

  /// List of tasks.
  final List<Task> tasks;

  /// Current revision.
  final int revision;
}
