import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:to_do/features/create_todo/domain/bloc/single_todo_bloc.dart';

/// Date picker for the task's deadline.
class DeadlinePicker extends StatelessWidget {
  /// Constructor of [DeadlinePicker].
  const DeadlinePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<SingleTodoBloc>();
    return BlocBuilder<SingleTodoBloc, SingleTodoState>(
      buildWhen: (previous, current) => previous.date != current.date,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.deadlineHeader,
                  overflow: TextOverflow.ellipsis,
                ),
                if (state.date != null)
                  Text(
                    DateFormat('d MMMM').format(state.date!),
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
              ],
            ),
            Switch.adaptive(
              value: state.date != null,
              onChanged: (isActive) async {
                if (isActive) {
                  final now = DateTime.now();
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: now,
                    lastDate: DateTime(2101),
                  );
                  bloc.add(SelectDate(selectedDate: picked));
                } else {
                  bloc.add(const SelectDate(selectedDate: null));
                }
              },
            )
          ],
        );
      },
    );
  }
}
