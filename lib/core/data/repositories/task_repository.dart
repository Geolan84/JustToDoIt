import 'dart:async';
import 'package:to_do/core/data/data_sources/db_data_provider.dart';
import 'package:to_do/core/data/data_sources/device_data_provider.dart';
import 'package:to_do/core/data/interceptors/api/task_api_client.dart';
import 'package:to_do/core/domain/task/task.dart';
import 'package:uuid/uuid.dart';

/// Repository for tasks operations.
class TaskRepository {
  /// Api client for tasks operations.
  final ITaskApiClient apiClient;

  /// Data provider for device id.
  final IDeviceDataProvider deviceDataProvider;

  /// Database data provider.
  final IDatabaseDataProvider databaseDataProvider;

  /// Temp revision;
  int? _currentRevision;

  /// Constructor of [TaskRepository].
  TaskRepository({
    required this.apiClient,
    required this.deviceDataProvider,
    required this.databaseDataProvider,
  });

  /// Loads tasks from server.
  Future<List<Task>> loadTasks() async {
    final response = await apiClient.getTasks();
    _currentRevision = response.revision;
    return response.tasks;
  }

  /// Updates revision.
  Future<int> getCurrentRevision() async {
    if (_currentRevision == null) {
      await loadTasks();
    }
    return _currentRevision ?? -1;
  }

  /// Adds new task.
  Future<Task> addTask(
    String text,
    Importance importance,
    int? deadline,
  ) async {
    final deviceId = await deviceDataProvider.getDeviceId();
    final currentTime = DateTime.now().microsecondsSinceEpoch;
    final newTask = Task(
      id: const Uuid().v4(),
      text: text,
      importance: importance,
      createdAt: currentTime,
      changedAt: currentTime,
      deviceId: deviceId,
    );
    await apiClient.addTask(
      newTask,
      await getCurrentRevision(),
    );
    if (_currentRevision != null) {
      _currentRevision = _currentRevision! + 1;
    }
    return newTask;
  }

  /// Deletes the task from server and cache.
  Future<void> deleteTask({
    required String id,
  }) async {
    await apiClient.deleteTaskById(
      id,
      await getCurrentRevision(),
    );
    if (_currentRevision != null) {
      _currentRevision = _currentRevision! + 1;
    }
  }

  /// Updates task data.
  Future<Task> updateTask({
    required Task task,
  }) async {
    task = task.copyWith(
      changedAt: DateTime.now().microsecondsSinceEpoch,
    );
    await apiClient.putTask(
      task,
      await getCurrentRevision(),
    );
    if (_currentRevision != null) {
      _currentRevision = _currentRevision! + 1;
    }
    return task;
  }
}
