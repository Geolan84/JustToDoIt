import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Text field for task's title.
class TitleTextField extends StatelessWidget {
  /// Text editing contoller for the task's title.
  final TextEditingController controller;

  /// Constructor of [TitleTextField].
  const TitleTextField({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return TextField(
      textAlignVertical: TextAlignVertical.top,
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        hintText: l10n.titleFieldHint,
        hintStyle: TextStyle(color: theme.colorScheme.onPrimary),
        filled: true,
        fillColor: theme.colorScheme.secondary,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      minLines: 4,
      maxLines: null,
    );
  }
}
