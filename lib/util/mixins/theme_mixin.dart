import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// Mixin for color and text styles.
mixin ThemeMixin<W extends ElementaryWidget, M extends ElementaryModel>
    on WidgetModel<W, M> implements IThemeMixin {
  late ColorScheme _colorScheme;
  late TextTheme _textTheme;

  @override
  ColorScheme get colorScheme => _colorScheme;

  @override
  TextTheme get textTheme => _textTheme;

  @override
  void didChangeDependencies() {
    _colorScheme = Theme.of(context).colorScheme;
    _textTheme = Theme.of(context).textTheme;
  }
}

/// A mixin for [ThemeMixin] to get color and text styles.
mixin IThemeMixin implements IWidgetModel {
  /// App color scheme.
  ColorScheme get colorScheme;

  /// App text style scheme.
  TextTheme get textTheme;
}
