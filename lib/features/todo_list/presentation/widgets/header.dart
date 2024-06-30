import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Sliver persistent header for all tasks screen.
class ToDoHeader extends StatelessWidget {
  /// Callback for visibility change.
  final VoidCallback onVisibilityChanged;

  /// Count of completed tasks.
  final int completedCount;

  /// Icon for filter button.
  final IconData icon;

  /// Constructor of [ToDoHeader].
  const ToDoHeader({
    required this.onVisibilityChanged,
    required this.completedCount,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: _HeaderDelegate(
        l10n.myTasks,
        completedCount,
        onVisibilityChanged,
        icon,
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;

  final int completedCount;

  final IconData icon;

  final VoidCallback onVisibilityChanged;

  const _HeaderDelegate(
    this.title,
    this.completedCount,
    this.onVisibilityChanged,
    this.icon,
  );

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final viewButton = IconButton(
      onPressed: onVisibilityChanged,
      icon: Icon(
        icon,
        color: colorScheme.primary,
      ),
    );
    final closedCount = Text(
      AppLocalizations.of(context)!.tasksCompleted(completedCount),
      style: TextStyle(
        color: colorScheme.onPrimary,
        fontSize: 16,
      ),
      overflow: TextOverflow.ellipsis,
    );
    const limit = 100;
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isExpanded = constraints.maxHeight > limit;
        final closedRow = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (isExpanded) closedCount,
            viewButton,
          ],
        );
        final title = Text(
          this.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isExpanded ? 34 : 20,
          ),
          overflow: TextOverflow.ellipsis,
        );

        return ColoredBox(
          color: theme.scaffoldBackgroundColor,
          child: Padding(
            padding: EdgeInsets.only(
              left: isExpanded ? 55 : 20,
              right: 10,
            ),
            child: isExpanded
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [title, closedRow],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [title, closedRow],
                  ),
          ),
        );
      },
    );
  }

  @override
  double get maxExtent => 200;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
