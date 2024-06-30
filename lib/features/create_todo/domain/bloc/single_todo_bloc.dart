import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do/core/domain/task/task.dart';

part 'single_todo_event.dart';
part 'single_todo_state.dart';

/// Bloc for creating or editing the task.
class SingleTodoBloc extends Bloc<SingleTodoEvent, SingleTodoState> {
  /// Costructor for single task bloc.
  SingleTodoBloc()
      : super(
          const SingleTodoInitialState(
            priority: Priority.no,
          ),
        ) {
    on<SelectDate>(_onSelectDate);
    on<SelectPriority>(_onSelectPriority);
    on<SaveTask>(_onSaveTask);
  }

  void _onSaveTask(SaveTask event, Emitter<SingleTodoState> emit) {}

  void _onSelectDate(SelectDate dateEvent, Emitter<SingleTodoState> emit) {
    emit(
      state.copyWith(
        date: dateEvent.selectedDate,
        resetDate: dateEvent.selectedDate == null,
      ),
    );
  }

  void _onSelectPriority(
      SelectPriority priorityEvent, Emitter<SingleTodoState> emit) {
    emit(
      state.copyWith(
        priority: priorityEvent.selectedPriority,
      ),
    );
  }
}
