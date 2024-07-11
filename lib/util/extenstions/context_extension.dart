import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Extension for locales, colors and text themes.
extension BuildContextExtension on BuildContext {
  /// Returns instanse with localized strings.
  AppLocalizations get l10n => AppLocalizations.of(this);

  /// Returns current color schema of app.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Returns current text theme of app.
  TextTheme get textTheme => Theme.of(this).textTheme;
}
