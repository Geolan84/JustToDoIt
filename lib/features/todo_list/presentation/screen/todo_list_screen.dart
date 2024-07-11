import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:to_do/features/todo_list/presentation/screen/todo_list_wm.dart';
import 'package:to_do/features/todo_list/presentation/widgets/header.dart';
import 'package:to_do/features/todo_list/presentation/widgets/tasks_list.dart';
import 'package:to_do/util/state_builders/error_state_widget.dart';
import 'package:to_do/util/state_builders/loading_state_widget.dart';

/// Elementary widget for to do list screen.
class ToDoListScreen extends ElementaryWidget<IToDoListScreenWM> {
  /// Constructor for screen widget.
  const ToDoListScreen({
    Key? key,
    WidgetModelFactory wmFactory = createToDoListScreenWM,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IToDoListScreenWM wm) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: wm.loadTasks,
          child: CustomScrollView(
            slivers: [
              DoubleValueListenableBuilder(
                firstValue: wm.completedCount,
                secondValue: wm.completedShow,
                builder: (_, completedCount, completedShow) => ToDoHeader(
                  onVisibilityChanged: wm.changeVisibility,
                  completedCount: completedCount,
                  completedShow: completedShow,
                ),
              ),
              EntityStateNotifierBuilder(
                listenableEntityState: wm.taskListState,
                builder: (_, tasks) => TasksList(
                  tasks: tasks,
                  onTaskCompleted: wm.onTaskCompleted,
                  onTaskDeleted: wm.onTaskDeleted,
                  onTaskClicked: wm.onTaskClicked,
                  newTaskCallback: wm.onNewTaskClick,
                ),
                loadingBuilder: (_, __) => const SliverFillRemaining(
                  child: LoadingStateWidget(),
                ),
                errorBuilder: (_, error, __) => SliverFillRemaining(
                  child: ErrorStateWidget(
                    errorText: '',
                    retryCallback: wm.loadTasks,
                    tryAgainText: wm.l10n.tryAgain,
                    exception: error,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: wm.colorScheme.secondary,
        ),
        onPressed: wm.onNewTaskClick,
      ),
    );
  }
}
