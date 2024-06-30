part of 'single_todo_bloc.dart';

/// Base class for single task state.
abstract class SingleTodoState extends Equatable {
  /// Date of task.
  final DateTime? date;

  /// Priority of task.
  final Priority priority;

  /// Constructor of state.
  const SingleTodoState({
    required this.priority,
    this.date,
  });

  /// Creates a copy of SingleTodoState with new arguments.
  SingleTodoState copyWith({
    DateTime? date,
    Priority? priority,
    bool resetDate = false,
  });

  @override
  List<Object?> get props => [priority, date];
}

/// Real state of single task.
final class SingleTodoInitialState extends SingleTodoState {
  /// Constructor for single task state.
  const SingleTodoInitialState({required super.priority, super.date});

  @override
  SingleTodoState copyWith({
    DateTime? date,
    Priority? priority,
    bool resetDate = false,
  }) {
    return SingleTodoInitialState(
      priority: priority ?? this.priority,
      date: resetDate ? null : date ?? this.date,
    );
  }
}
