import 'package:dio/dio.dart';
import 'package:to_do/core/data/models/task_response.dart';
import 'package:to_do/core/domain/task/task.dart';
import 'package:to_do/util/app_urls.dart';

/// Interface for task api client.
abstract interface class ITaskApiClient {
  /// Gets tasks from server.
  Future<TaskResponse> getTasks();

  /// Sends new task to server.
  Future<void> addTask(
    Task task,
    int revision,
  );

  /// Deletes task by id on the server.
  Future<void> deleteTaskById(
    String id,
    int revision,
  );

  /// Updates task on the server.
  Future<void> putTask(
    Task task,
    int revision,
  );
}

/// Api client for tasks operations.
class TaskApiClient implements ITaskApiClient {
  /// Dio client for http requests.
  final Dio dioClient;

  /// @nodoc.
  TaskApiClient({required this.dioClient});

  @override
  Future<TaskResponse> getTasks() async {
    final response = await dioClient.get(AppUrls.tasksList);
    final body = response.data as Map<String, dynamic>;
    final revision = body[_TasksRequestConstants.revisionKey] as int;
    final tasks = (body[_TasksRequestConstants.tasksListKey] as List<dynamic>)
        .map(
          (task) => Task.fromJson(task as Map<String, dynamic>),
        )
        .toList();
    return TaskResponse(tasks: tasks, revision: revision);
  }

  @override
  Future<void> addTask(Task task, int revision) async {
    await dioClient.post(
      AppUrls.tasksList,
      data: {
        _TasksRequestConstants.elementKey: task.toJson(),
      },
      options: Options(
        headers: {
          _TasksRequestConstants.revisionHeader: revision,
        },
      ),
    );
  }

  @override
  Future<void> deleteTaskById(
    String id,
    int revision,
  ) async {
    await dioClient.delete(
      '${AppUrls.singleTask}/$id',
      options: Options(
        headers: {
          _TasksRequestConstants.revisionHeader: revision,
        },
      ),
    );
  }

  @override
  Future<void> putTask(Task task, int revision) async {
    await dioClient.put(
      '${AppUrls.singleTask}/${task.id}',
      data: {
        _TasksRequestConstants.elementKey: task.toJson(),
      },
      options: Options(
        headers: {
          _TasksRequestConstants.revisionHeader: revision,
        },
      ),
    );
  }
}

class _TasksRequestConstants {
  static const elementKey = 'element';
  static const revisionHeader = 'X-Last-Known-Revision';
  static const tasksListKey = 'list';
  static const revisionKey = 'revision';
}
