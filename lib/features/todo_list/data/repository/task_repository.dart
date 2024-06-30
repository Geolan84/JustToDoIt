import 'dart:async';
import 'package:to_do/core/data/interceptors/api/task_api_client.dart';
import 'package:to_do/core/domain/task/task.dart';

/// Repository for tasks operations.
class TaskRepository {
  /// Api client for tasks operations.
  final ITaskApiClient apiClient;

  final _controller = StreamController<List<Task>>();

  /// Constructor of [TaskRepository].
  TaskRepository({required this.apiClient});

  /// Getter for tasks stream.
  Stream<List<Task>> get tasksStream => _controller.stream;

  /// Loads tasks from server.
  Future<void> loadTasks() async {
    final newTasks = await apiClient.getTasks();
    _controller.add(newTasks);
  }

  /// Adds new task.
  Future<void> addTask(Task task) async {
    // TODO(Geolan84): add revision check.
    await apiClient.addTask(task, 0);
  }

  /// Dispose for streams.
  void dispose() {
    _controller.close();
  }
}
