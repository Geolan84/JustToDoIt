import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do/core/data/data_sources/db_data_provider.dart';
import 'package:to_do/core/data/data_sources/device_data_provider.dart';
import 'package:to_do/core/data/interceptors/api/task_api_client.dart';
import 'package:to_do/core/data/interceptors/auth_interceptor.dart';
import 'package:to_do/core/data/repositories/task_repository.dart';
import 'package:to_do/util/handlers/error_handler.dart';

/// Service locator
final _locator = GetIt.instance;

/// Getter for locator.
GetIt get locator => _locator;

/// Initialize all necessary dependencies.
void initServiceLocator() {
  locator
    ..registerSingleton<Dio>(
      Dio()
        ..httpClientAdapter = IOHttpClientAdapter(
          createHttpClient: () {
            final client = HttpClient(context: SecurityContext())
              ..badCertificateCallback = (_, __, ___) => true;
            return client;
          },
        )
        ..interceptors.add(
          AuthInterceptor(
            // ignore: do_not_use_environment
            token: const String.fromEnvironment('BEARER_TOKEN'),
          ),
        ),
    )
    ..registerSingleton<TaskApiClient>(
      TaskApiClient(
        dioClient: _locator.get<Dio>(),
      ),
    )
    ..registerSingleton<IDeviceDataProvider>(
      DeviceDataProvider(),
    )
    ..registerSingleton<IDatabaseDataProvider>(
      DatabaseDataProvider(),
    )
    ..registerSingleton<TaskRepository>(
      TaskRepository(
        apiClient: _locator.get<TaskApiClient>(),
        deviceDataProvider: _locator.get<IDeviceDataProvider>(),
        databaseDataProvider: _locator.get<IDatabaseDataProvider>(),
      ),
    )
    ..registerSingleton<TaskErrorHandler>(
      TaskErrorHandler(),
    );
}
