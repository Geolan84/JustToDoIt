import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/core/domain/task/task.dart';
import 'package:to_do/features/create_todo/domain/bloc/single_todo_bloc.dart';
import 'package:to_do/features/create_todo/presentation/widgets/deadline_picker.dart';
import 'package:to_do/features/create_todo/presentation/widgets/delete_button.dart';
import 'package:to_do/features/create_todo/presentation/widgets/priority_field.dart';
import 'package:to_do/features/create_todo/presentation/widgets/task_app_bar.dart';
import 'package:to_do/features/create_todo/presentation/widgets/title_text_field.dart';

/// Screen for creating or editing the task.
class SingleToDoScreen extends StatefulWidget {
  /// Existent task to edit.
  final Task? task;

  /// Constructor for single task screen.
  const SingleToDoScreen({this.task, super.key});

  @override
  State<SingleToDoScreen> createState() => _SingleToDoScreenState();
}

class _SingleToDoScreenState extends State<SingleToDoScreen> {
  final textController = TextEditingController();

  final bloc = SingleTodoBloc();

  @override
  void initState() {
    super.initState();
    textController.text = widget.task?.title ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        appBar: TaskAppBar(
          closeActionCallback: () => Navigator.of(context).pop(),
          saveActionCallback: () => saveTask(bloc),
          saveActionTitle: l10n.saveButtonTitle,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: Column(
                  children: [
                    TitleTextField(controller: textController),
                    const PriorityField(),
                    const Divider(thickness: 0.5),
                    const DeadlinePicker(),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Divider(thickness: 0.5),
              DeleteButton(
                title: l10n.deleteButtonTitle,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveTask(SingleTodoBloc bloc) {
    Navigator.of(context).pop((
      textController.value.text,
      bloc.state.priority,
      bloc.state.date,
    ));
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
