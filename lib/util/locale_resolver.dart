import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/core/domain/task/task.dart';

/// Returns string title of priority in current locale.
String getLocalizedPriority(AppLocalizations l10n, Importance value) {
  return switch (value) {
    Importance.low => l10n.importanceLow,
    Importance.basic => l10n.importanceBasic,
    Importance.important => l10n.importanceImportant,
  };
}
