import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/core/domain/task/task.dart';
import 'package:to_do/features/create_todo/domain/bloc/single_todo_bloc.dart';

/// Popup menu for priority selection.
class PriorityField extends StatelessWidget {
  /// Constructor of [PriorityField]
  const PriorityField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final bloc = context.read<SingleTodoBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: BlocBuilder<SingleTodoBloc, SingleTodoState>(
            bloc: bloc,
            buildWhen: (previous, current) =>
                previous.priority != current.priority,
            builder: (context, state) {
              return PopupMenuButton<Priority>(
                initialValue: Priority.no,
                onSelected: (value) => bloc.add(
                  SelectPriority(selectedPriority: value),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: Priority.no,
                    child: Text(
                      l10n.priorityNone,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  PopupMenuItem(
                    value: Priority.low,
                    child: Text(
                      l10n.priorityLow,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  PopupMenuItem(
                    value: Priority.high,
                    child: Text(
                      l10n.priorityHigh,
                      style: TextStyle(
                        color: theme.colorScheme.error,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.priorityHeader,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      getLocalizedPriority(l10n, state.priority),
                      style: TextStyle(color: theme.colorScheme.onPrimary),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  /// Returns string title of priority in current locale.
  String getLocalizedPriority(AppLocalizations l10n, Priority value) {
    return switch (value) {
      Priority.no => l10n.priorityNone,
      Priority.low => l10n.priorityLow,
      Priority.high => l10n.priorityHigh,
    };
  }
}
