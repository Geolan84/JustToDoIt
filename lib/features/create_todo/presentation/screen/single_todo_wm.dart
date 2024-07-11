import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_do/core/data/repositories/task_repository.dart';
import 'package:to_do/core/domain/task/task.dart';
import 'package:to_do/features/create_todo/presentation/screen/single_todo_model.dart';
import 'package:to_do/features/create_todo/presentation/screen/single_todo_screen.dart';
import 'package:to_do/util/handlers/error_handler.dart';
import 'package:to_do/util/mixins/localization_mixin.dart';
import 'package:to_do/util/mixins/theme_mixin.dart';
import 'package:to_do/util/service_locator.dart';

/// Factory for [SingleToDoScreenWM].
SingleToDoScreenWM createSingleToDoScreenWM(BuildContext context) {
  return SingleToDoScreenWM(
    SingleToDoScreenModel(
      locator.get<TaskErrorHandler>(),
      taskRepository: locator.get<TaskRepository>(),
    ),
  );
}

/// Default widget model for single to do screen.
class SingleToDoScreenWM
    extends WidgetModel<SingleToDoScreen, SingleToDoScreenModel>
    with LocalizationMixin, ThemeMixin
    implements ISingleToDoScreenWM {
  /// Create an instance [SingleToDoScreenWM].
  SingleToDoScreenWM(
    super._model,
  );

  @override
  TextEditingController get textController => _textController;

  final _textController = TextEditingController();

  final _newImportance = ValueNotifier<Importance>(Importance.low);

  final _newDeadline = ValueNotifier<int?>(null);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _textController.text = widget.task?.text ?? '';
    _newDeadline.value = widget.task?.deadline;
    _newImportance.value = widget.task?.importance ?? Importance.low;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void onCloseForm() {
    Navigator.of(context).pop();
  }

  @override
  Future<void> onSaveForm() async {
    Task? result;
    final currentTask = widget.task;
    if (currentTask != null) {
      result = currentTask.copyWith(
        text: _textController.value.text,
        deadline: _newDeadline.value,
        importance: _newImportance.value,
        resetDeadline: _newDeadline.value == null,
      );
      result = await model.updateTask(
        task: result,
      );
    } else {
      result = await model.addTask(
        text: _textController.value.text,
        importance: _newImportance.value,
        deadline: _newDeadline.value,
      );
    }
    widget.onTaskAdded?.call(result);
    onCloseForm();
  }

  @override
  ValueListenable<Importance> get newImportance => _newImportance;

  @override
  ValueListenable<int?> get newDeadline => _newDeadline;

  @override
  void onImportanceChanged(Importance newValue) {
    _newImportance.value = newValue;
  }

  @override
  void onDeadlineChanged(DateTime? newValue) {
    if (newValue != null) {
      _newDeadline.value = newValue.microsecondsSinceEpoch;
    } else {
      _newDeadline.value = null;
    }
  }

  @override
  Future<void> onDeleteTask() async {
    final task = widget.task;
    if (task != null) {
      widget.onTaskDeleted?.call(task);
    }
    onCloseForm();
  }
}

/// Interface of [SingleToDoScreenWM].
abstract class ISingleToDoScreenWM
    with ILocalizationMixin, IThemeMixin
    implements IWidgetModel {
  /// Controller for text of to do.
  TextEditingController get textController;

  /// Callback to close the form.
  void onCloseForm();

  /// Callback to save the form.
  void onSaveForm();

  /// Callback to delete the task.
  Future<void> onDeleteTask();

  /// Callback to update selected importance.
  void onImportanceChanged(Importance newValue);

  /// Callback to update selected deadline.
  void onDeadlineChanged(DateTime? newValue);

  /// Getter for listenable state of importance field.
  ValueListenable<Importance> get newImportance;

  /// Getter for listenable state of deadline field.
  ValueListenable<int?> get newDeadline;
}
