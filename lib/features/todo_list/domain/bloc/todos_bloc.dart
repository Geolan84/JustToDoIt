import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do/core/domain/task/task.dart';
import 'package:to_do/features/todo_list/data/repository/task_repository.dart';
import 'package:uuid/uuid.dart';

part 'todos_event.dart';
part 'todos_state.dart';

/// Bloc for all tasks.
class TodosBloc extends Bloc<TodosEvent, TodosState> {
  /// Repository for tasks.
  final TaskRepository repository;

  /// Stream with tasks.
  StreamSubscription<List<Task>>? tasksStream;

  /// Constructor of [TodosBloc]
  TodosBloc(this.repository)
      : super(
          const TodosInitialState(
            allTasks: [],
            isFiltered: false,
            completedCount: 0,
          ),
        ) {
    on<LoadList>(_onLoadTasks);
    on<UpdateList>(_onUpdateList);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<SwitchFilter>(_onSwitchFilter);

    tasksStream = repository.tasksStream.listen((event) {
      add(UpdateList(event));
    });
  }

  void _onUpdateList(UpdateList event, Emitter<TodosState> emit) {
    final isFiltered = event.isFiltered ?? state.isFiltered;
    final result = isFiltered
        ? event.tasks.where((element) => !element.isDone).toList()
        : event.tasks;
    final doneTasksCount =
        event.tasks.where((element) => element.isDone).length;
    emit(TodosInitialState(
        allTasks: result,
        isFiltered: isFiltered,
        completedCount: doneTasksCount));
  }

  Future<void> _onLoadTasks(LoadList event, Emitter<TodosState> emit) async {
    emit(
      TodosLoadingState(
        allTasks: state.allTasks,
        isFiltered: state.isFiltered,
        completedCount: state.completedCount,
      ),
    );
    await repository.loadTasks();
  }

  void _onSwitchFilter(SwitchFilter edit, Emitter<TodosState> emit) {
    add(UpdateList(state.allTasks, isFiltered: !state.isFiltered));
  }

  Future<void> _onAddTask(AddTask event, Emitter<TodosState> emit) async {
    final device = await DeviceInfoPlugin().deviceInfo;
    final newTask = Task(
      id: const Uuid().v4(),
      title: event.title,
      priority: event.priority,
      date: event.date,
      createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      changedAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      deviceId: device.data['id'].toString(),
    );
    await repository.addTask(newTask);
  }

  void _onUpdateTask(UpdateTask event, Emitter<TodosState> emit) {}

  void _onDeleteTask(DeleteTask event, Emitter<TodosState> emit) {}

  @override
  Future<void> close() {
    tasksStream?.cancel();
    return super.close();
  }
}
