import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/features/todo_list/presentation/screen/todo_list_screen.dart';
import 'package:to_do/util/service_locator.dart';
import 'package:to_do/util/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  initServiceLocator();
  runApp(
    const ToDoApp(),
  );
}

/// App Widget.
class ToDoApp extends StatelessWidget {
  /// Constructor of [ToDoApp].
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const ToDoListScreen(),
    );
  }
}
