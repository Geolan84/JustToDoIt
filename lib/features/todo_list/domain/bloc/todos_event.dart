part of 'todos_bloc.dart';

/// Base class for tasks event.
sealed class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load data.
final class LoadList extends TodosEvent {
  /// Flag for all tasks.
  final bool needAllTasks;

  /// Constructor of [LoadList] event.
  const LoadList({required this.needAllTasks});

  @override
  List<Object> get props => [needAllTasks];
}

/// Updates list.
final class UpdateList extends TodosEvent {
  /// Tasks.
  final List<Task> tasks;

  /// Flag for filter status.
  final bool? isFiltered;

  /// Constructor of [UpdateList] event.
  const UpdateList(this.tasks, {this.isFiltered});

  @override
  List<Object?> get props => [tasks, isFiltered];
}

/// Event for filter changes.
final class SwitchFilter extends TodosEvent {
  /// Constructor of [SwitchFilter].
  const SwitchFilter();
}

/// Event for task adding.
final class AddTask extends TodosEvent {
  /// New task title.
  final String title;

  /// Priority.
  final Priority priority;

  /// Deadline.
  final DateTime? date;

  /// Constructor of [AddTask] event.
  const AddTask({
    required this.title,
    required this.priority,
    this.date,
  });

  @override
  List<Object> get props => [
        title,
        priority,
      ];
}

/// Event for task updating.
final class UpdateTask extends TodosEvent {
  /// Updated task.
  final Task task;

  /// Constructor of [UpdateTask] event.
  const UpdateTask({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

/// Event for task deleting.
final class DeleteTask extends TodosEvent {
  /// Task to delete.
  final Task task;

  /// Constructor of [DeleteTask] event.
  const DeleteTask({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}
