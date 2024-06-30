part of 'single_todo_bloc.dart';

/// Base event for single task.
sealed class SingleTodoEvent extends Equatable {
  const SingleTodoEvent();

  @override
  List<Object?> get props => [];
}

/// Event for date selection.
final class SelectDate extends SingleTodoEvent {
  /// Selected date.
  final DateTime? selectedDate;

  /// Constructor for SelectDate event.
  const SelectDate({
    required this.selectedDate,
  });

  @override
  List<Object?> get props => [selectedDate];
}

/// Event for priority selection.
final class SelectPriority extends SingleTodoEvent {
  /// Selected priority.
  final Priority selectedPriority;

  /// Constructor for SelectedPriority event.
  const SelectPriority({
    required this.selectedPriority,
  });

  @override
  List<Object> get props => [selectedPriority];
}

/// Event to save the task.
final class SaveTask extends SingleTodoEvent {
  /// Task to save.
  final Task task;

  /// Constructor of [SaveTask] event.
  const SaveTask({required this.task});

  @override
  List<Object> get props => [task];
}
