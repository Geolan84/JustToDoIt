import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 247, 246, 242),
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      brightness: Brightness.light,
      primary: const Color.fromARGB(255, 0, 122, 255),
      onPrimary: Colors.grey.shade400,
      secondary: Colors.white,
      error: const Color.fromARGB(255, 255, 59, 48),
      onSecondary: Colors.green,
    ),
  );
}
