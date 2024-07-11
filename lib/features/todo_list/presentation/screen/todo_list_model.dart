import 'package:elementary/elementary.dart';
import 'package:to_do/core/data/repositories/task_repository.dart';
import 'package:to_do/core/domain/task/task.dart';
import 'package:to_do/features/todo_list/presentation/screen/todo_list_screen.dart';

/// Model for [ToDoListScreen]
class ToDoListScreenModel extends ElementaryModel {
  /// Task repository instance.
  final TaskRepository taskRepository;

  /// Constructor for ToDoListScreen model.
  ToDoListScreenModel(
    ErrorHandler errorHandler, {
    required this.taskRepository,
  }) : super(errorHandler: errorHandler);

  /// Loads tasks from server.
  Future<List<Task>> getTasks() async {
    try {
      return taskRepository.loadTasks();
    } on Exception catch (e) {
      handleError(e);
      rethrow;
    }
  }

  /// Deletes existent task.
  Future<void> deleteTask({
    required Task task,
  }) async {
    try {
      await taskRepository.deleteTask(
        id: task.id,
      );
    } on Exception catch (e) {
      handleError(e);
      rethrow;
    }
  }

  /// Updates the task.
  Future<Task> updateTask({
    required Task task,
  }) async {
    try {
      return await taskRepository.updateTask(
        task: task,
      );
    } on Exception catch (e) {
      handleError(e);
      rethrow;
    }
  }
}
