import 'package:flutter/material.dart';
import 'package:to_do/util/extenstions/context_extension.dart';

/// Sliver persistent header for all tasks screen.
class ToDoHeader extends StatelessWidget {
  /// Callback for visibility change.
  final VoidCallback onVisibilityChanged;

  /// Count of completed tasks.
  final int? completedCount;

  /// State of 'visibility' icon.
  final bool? completedShow;

  /// Constructor of [ToDoHeader].
  const ToDoHeader({
    required this.onVisibilityChanged,
    required this.completedCount,
    required this.completedShow,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: _HeaderDelegate(
        title: context.l10n.myTasks,
        completedCount: completedCount,
        completedShow: completedShow,
        onVisibilityChanged: onVisibilityChanged,
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;

  final int? completedCount;

  final bool? completedShow;

  final VoidCallback onVisibilityChanged;

  const _HeaderDelegate({
    required this.title,
    required this.completedCount,
    required this.completedShow,
    required this.onVisibilityChanged,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final viewButton = completedShow == null
        ? const SizedBox.shrink()
        : IconButton(
            onPressed: onVisibilityChanged,
            icon: Icon(
              completedShow! ? Icons.visibility_off : Icons.visibility,
              color: context.colorScheme.primary,
            ),
          );
    final closedCount = completedCount == null
        ? const SizedBox.shrink()
        : Text(
            context.l10n.tasksCompleted(completedCount!),
            style: TextStyle(
              color: context.colorScheme.onPrimary,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
          );
    const limit = 100;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isExpanded = constraints.maxHeight > limit;
        final closedRow = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (isExpanded && completedShow != null) closedCount,
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
          color: Theme.of(context).scaffoldBackgroundColor,
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
