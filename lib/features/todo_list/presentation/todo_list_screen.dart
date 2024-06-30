import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/core/domain/task/task.dart';
import 'package:to_do/features/create_todo/presentation/single_todo_screen.dart';
import 'package:to_do/features/todo_list/domain/bloc/todos_bloc.dart';
import 'package:to_do/features/todo_list/presentation/widgets/header.dart';
import 'package:to_do/features/todo_list/presentation/widgets/tasks_list.dart';

/// Screen with all tasks.
class ToDoListScreen extends StatefulWidget {
  /// Constructor for all tasks screen.
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<TodosBloc>();
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) => Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              ToDoHeader(
                onVisibilityChanged: () => bloc.add(const SwitchFilter()),
                completedCount: state.completedCount,
                icon:
                    state.isFiltered ? Icons.visibility_off : Icons.visibility,
              ),
              TasksList(
                tasks: state.allTasks,
                newTaskCallback: () => createNewTask(bloc),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: theme.colorScheme.secondary,
          ),
          onPressed: () => createNewTask(bloc),
        ),
      ),
    );
  }

  /// Opens dialog to create a task.
  Future<void> createNewTask(TodosBloc bloc) async {
    final newTaskData = await Navigator.push<(String, Priority, DateTime?)>(
      context,
      MaterialPageRoute(
        builder: (_) => const SingleToDoScreen(),
      ),
    );
    if (newTaskData != null) {
      bloc.add(AddTask(
        title: newTaskData.$1,
        priority: newTaskData.$2,
        date: newTaskData.$3,
      ));
    }
  }
}
