import 'package:elementary/elementary.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Mixin for widget model which provides localization.
mixin LocalizationMixin<W extends ElementaryWidget, M extends ElementaryModel>
    on WidgetModel<W, M> implements ILocalizationMixin {
  @override
  AppLocalizations get l10n => AppLocalizations.of(context);
}

/// Mixin for widget model which provides localization.
mixin ILocalizationMixin implements IWidgetModel {
  /// App localization getter.
  AppLocalizations get l10n;
}
