part of 'todos_bloc.dart';

/// State for all tasks block.
abstract class TodosState extends Equatable {
  /// All tasks.
  final List<Task> allTasks;

  /// Flag for tasks filter status.
  final bool isFiltered;

  /// Count of completed tasks count.
  final int completedCount;

  /// Constructor of [TodosState].
  const TodosState({
    required this.allTasks,
    required this.isFiltered,
    required this.completedCount,
  });

  @override
  List<Object> get props => [
        allTasks,
        isFiltered,
        completedCount,
      ];
}

/// Initial state.
class TodosInitialState extends TodosState {
  /// Constructor of [TodosInitialState]
  const TodosInitialState({
    required super.allTasks,
    required super.isFiltered,
    required super.completedCount,
  });
}

/// Loading state.
class TodosLoadingState extends TodosState {
  /// Constructor of [TodosLoadingState]
  const TodosLoadingState({
    required super.allTasks,
    required super.isFiltered,
    required super.completedCount,
  });
}
