import 'package:dio/dio.dart';
import 'package:to_do/core/domain/task/task.dart';
import 'package:to_do/util/app_urls.dart';

/// Interface for task api client.
abstract interface class ITaskApiClient {
  /// Gets tasks from server.
  Future<List<Task>> getTasks();

  /// Sends new task to server.
  Future<void> addTask(Task task, int revision);
}

/// Api client for tasks operations.
class TaskApiClient implements ITaskApiClient {
  /// Dio client for http requests.
  final Dio dioClient;

  /// @nodoc.
  TaskApiClient({required this.dioClient});

  @override
  Future<List<Task>> getTasks() async {
    final response = await dioClient.get(AppUrls.tasksList);
    if (response.statusCode != 200) {
      throw Exception(response.toString());
    }
    return ((response.data as Map<String, dynamic>)['list'] as List<dynamic>)
        .map(Task.fromJson)
        .toList();
  }

  @override
  Future<void> addTask(Task task, int revision) async {
    final response = await dioClient.post(
      AppUrls.tasksList,
      data: {'element': task.toMap()},
      options: Options(
        headers: {
          'X-Last-Known-Revision': revision,
        },
      ),
    );
    if (response.statusCode != 200) {
      throw Exception(response.toString());
    }
  }
}
