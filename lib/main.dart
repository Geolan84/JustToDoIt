import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      home: const ToDoListScreen(),
    );
  }
}
