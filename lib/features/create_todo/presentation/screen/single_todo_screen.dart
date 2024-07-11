import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:to_do/core/domain/task/task.dart';
import 'package:to_do/features/create_todo/presentation/screen/single_todo_wm.dart';
import 'package:to_do/features/create_todo/presentation/widgets/deadline_picker.dart';
import 'package:to_do/features/create_todo/presentation/widgets/delete_button.dart';
import 'package:to_do/features/create_todo/presentation/widgets/priority_field.dart';
import 'package:to_do/features/create_todo/presentation/widgets/task_app_bar.dart';
import 'package:to_do/features/create_todo/presentation/widgets/title_text_field.dart';

/// Screen for for creating or editing single to do.
class SingleToDoScreen extends ElementaryWidget<ISingleToDoScreenWM> {
  /// Task to open.
  final Task? task;

  /// Callback to save the task.
  final Function(Task)? onTaskAdded;

  /// Callback to delete the task.
  final Function(Task)? onTaskDeleted;

  /// Constructor for single to do list screen.
  const SingleToDoScreen({
    this.onTaskAdded,
    this.onTaskDeleted,
    this.task,
    Key? key,
    WidgetModelFactory wmFactory = createSingleToDoScreenWM,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISingleToDoScreenWM wm) {
    return Scaffold(
      appBar: TaskAppBar(
        closeActionCallback: wm.onCloseForm,
        saveActionCallback: wm.onSaveForm,
        saveActionTitle: wm.l10n.saveButtonTitle,
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
                  TitleTextField(
                    controller: wm.textController,
                  ),
                  ImportanceField(
                    importance: wm.newImportance,
                    onValueChanged: wm.onImportanceChanged,
                  ),
                  const Divider(thickness: 0.5),
                  DeadlinePicker(
                    deadline: wm.newDeadline,
                    onDeadlineChanged: wm.onDeadlineChanged,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 0.5),
            DeleteButton(
              title: wm.l10n.deleteButtonTitle,
              onTap: wm.onDeleteTask,
            ),
          ],
        ),
      ),
    );
  }
}
