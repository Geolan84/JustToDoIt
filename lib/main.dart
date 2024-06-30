import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/core/data/interceptors/api/task_api_client.dart';
import 'package:to_do/core/data/interceptors/auth_interceptor.dart';
import 'package:to_do/features/todo_list/data/repository/task_repository.dart';
import 'package:to_do/features/todo_list/domain/bloc/todos_bloc.dart';
import 'package:to_do/features/todo_list/presentation/todo_list_screen.dart';
import 'package:to_do/util/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

/// App Widget.
class MyApp extends StatelessWidget {
  /// Constructor of [MyApp].
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient(context: SecurityContext())
          ..badCertificateCallback = (_, __, ___) => true;
        return client;
      },
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider(
        create: (context) => TodosBloc(
          TaskRepository(
            apiClient: TaskApiClient(
              dioClient: Dio()
                ..httpClientAdapter = httpClientAdapter
                ..interceptors.add(
                  AuthInterceptor(
                    // ignore: do_not_use_environment
                    token: const String.fromEnvironment('BEARER_TOKEN'),
                  ),
                ),
            ),
          ),
        )..add(
            const LoadList(needAllTasks: true),
          ),
        child: const ToDoListScreen(),
      ),
    );
  }
}
