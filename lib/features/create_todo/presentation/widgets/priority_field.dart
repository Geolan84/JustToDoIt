import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_do/core/domain/task/task.dart';
import 'package:to_do/util/extenstions/context_extension.dart';
import 'package:to_do/util/locale_resolver.dart';

/// Popup menu for importance selection.
class ImportanceField extends StatelessWidget {
  /// Current importance value.
  final ValueListenable<Importance> importance;

  /// Callback for importance value changes.
  final Function(Importance) onValueChanged;

  /// Constructor of [ImportanceField]
  const ImportanceField({
    required this.importance,
    required this.onValueChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ValueListenableBuilder(
          valueListenable: importance,
          builder: (_, currentImportance, __) => PopupMenuButton<Importance>(
            initialValue: currentImportance,
            onSelected: onValueChanged,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: Importance.low,
                child: Text(
                  context.l10n.importanceLow,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              PopupMenuItem(
                value: Importance.basic,
                child: Text(
                  context.l10n.importanceBasic,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              PopupMenuItem(
                value: Importance.important,
                child: Text(
                  context.l10n.importanceImportant,
                  style: TextStyle(
                    color: context.colorScheme.error,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.priorityHeader,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  getLocalizedPriority(
                    context.l10n,
                    currentImportance,
                  ),
                  style: TextStyle(color: context.colorScheme.onPrimary),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
