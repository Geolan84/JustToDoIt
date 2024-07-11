import 'package:elementary/elementary.dart';
import 'package:to_do/core/data/repositories/task_repository.dart';
import 'package:to_do/core/domain/task/task.dart';

/// Model for single to do screen.
class SingleToDoScreenModel extends ElementaryModel {
  /// Repository for tasks operations.
  final TaskRepository taskRepository;

  /// Constructor for [SingleToDoScreenModel]
  SingleToDoScreenModel(ErrorHandler errorHandler,
      {required this.taskRepository})
      : super(errorHandler: errorHandler);

  /// Saves new task.
  Future<Task> addTask({
    required String text,
    required Importance importance,
    int? deadline,
  }) async {
    try {
      return await taskRepository.addTask(
        text,
        importance,
        deadline,
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
