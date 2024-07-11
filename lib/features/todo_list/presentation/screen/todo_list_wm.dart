import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_do/core/data/repositories/task_repository.dart';
import 'package:to_do/core/domain/task/task.dart';
import 'package:to_do/features/create_todo/presentation/screen/single_todo_screen.dart';
import 'package:to_do/features/todo_list/presentation/screen/todo_list_model.dart';
import 'package:to_do/features/todo_list/presentation/screen/todo_list_screen.dart';
import 'package:to_do/util/handlers/error_handler.dart';
import 'package:to_do/util/mixins/localization_mixin.dart';
import 'package:to_do/util/mixins/theme_mixin.dart';
import 'package:to_do/util/service_locator.dart';

/// Factory for [ToDoListScreenWM].
ToDoListScreenWM createToDoListScreenWM(BuildContext context) {
  return ToDoListScreenWM(
    ToDoListScreenModel(
      locator.get<TaskErrorHandler>(),
      taskRepository: locator.get<TaskRepository>(),
    ),
  );
}

/// Default widget model for to do list screen.
class ToDoListScreenWM extends WidgetModel<ToDoListScreen, ToDoListScreenModel>
    with LocalizationMixin, ThemeMixin
    implements IToDoListScreenWM {
  /// Create an instance [ToDoListScreenWM].
  ToDoListScreenWM(
    super._model,
  );

  List<Task>? _allTasks;

  final _taskListState = EntityStateNotifier<List<Task>?>();

  final _showCompletedNotifier = ValueNotifier<bool?>(null);

  final _completedCountNotifier = ValueNotifier<int?>(null);

  bool? _previousShowCompletedMode;

  @override
  Future<void> loadTasks() async {
    final previousData = _taskListState.value.data;
    _taskListState.loading(previousData);
    try {
      _allTasks = await model.getTasks();
      _showCompletedNotifier.value = _previousShowCompletedMode ?? false;
      _filterTasks();
    } on Exception catch (e) {
      _taskListState.error(e);
    }
  }

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    loadTasks();
  }

  @override
  void onNewTaskClick() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SingleToDoScreen(
          onTaskAdded: _onTaskAdded,
          onTaskDeleted: onTaskDeleted,
        ),
      ),
    );
  }

  @override
  void changeVisibility() {
    final currentValue = _showCompletedNotifier.value;
    if (currentValue != null) {
      _previousShowCompletedMode = currentValue;
      _showCompletedNotifier.value = !currentValue;
      _filterTasks();
    }
  }

  void _updateCompletedCount() {
    _completedCountNotifier.value =
        _allTasks?.where((element) => element.isDone).length;
  }

  void _filterTasks() {
    _updateCompletedCount();
    final currentMode = _showCompletedNotifier.value;
    if (currentMode != null) {
      if (currentMode) {
        _taskListState.content(_allTasks);
      } else {
        _taskListState.content(
          _allTasks
              ?.where(
                (element) => element.isDone == currentMode,
              )
              .toList(),
        );
      }
    }
  }

  @override
  ValueListenable<EntityState<List<Task>?>> get taskListState => _taskListState;

  @override
  ValueListenable<bool?> get completedShow => _showCompletedNotifier;

  @override
  ValueListenable<int?> get completedCount => _completedCountNotifier;

  @override
  Future<void> onTaskCompleted(Task task) async {
    final taskIndex = _allTasks?.indexOf(task);
    if (taskIndex != null) {
      final newTask = task.copyWith(isDone: !task.isDone);
      await model.updateTask(task: newTask);
      _allTasks?.removeAt(taskIndex);
      _allTasks?.insert(taskIndex, newTask);
      _filterTasks();
    }
  }

  @override
  Future<void> onTaskDeleted(Task task) async {
    await model.deleteTask(task: task);
    _allTasks?.remove(task);
    _filterTasks();
  }

  @override
  void onTaskClicked(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SingleToDoScreen(
          task: task,
          onTaskAdded: _onTaskAdded,
          onTaskDeleted: onTaskDeleted,
        ),
      ),
    );
  }

  void _onTaskAdded(Task task) {
    final index = _allTasks?.indexWhere(
      (element) => element.id == task.id,
    );
    if (index != null) {
      if (index == -1) {
        _allTasks?.add(task);
      } else {
        _allTasks?.removeAt(index);
        _allTasks?.insert(index, task);
      }
      _filterTasks();
    }
  }
}

/// Interface of [ToDoListScreenWM].
abstract class IToDoListScreenWM
    with ILocalizationMixin, IThemeMixin
    implements IWidgetModel {
  /// Callback for opening task creation form.
  void onNewTaskClick();

  /// Loads tasks to show on the screen.
  Future<void> loadTasks();

  /// Getter for listenable state of list with tasks.
  ValueListenable<EntityState<List<Task>?>> get taskListState;

  /// Getter for listenable state for completed count text.
  ValueListenable<int?> get completedCount;

  /// Getter for listenable state for completed tasks visibility change button.
  ValueListenable<bool?> get completedShow;

  /// Callback to change visibility.
  void changeVisibility();

  /// Callback for task complete by dismiss action.
  Future<void> onTaskCompleted(Task task);

  /// Callback for task deletion by dismiss action.
  Future<void> onTaskDeleted(Task task);

  /// Callback to open task editing form.
  void onTaskClicked(Task task);
}
