import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:to_do/features/create_todo/presentation/new_todo_screen.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final List<String> taskStub =
      List.generate(15, (index) => "Купить что-то $index");

  final List<String> completed = List.empty(growable: true);

  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: _HeaderDelegate("Мои дела"),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(10),
              sliver: DecoratedSliver(
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                  borderRadius: BorderRadius.circular(15),
                ),
                sliver: SliverList.builder(
                  itemCount: taskStub.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: Key(taskStub[index]),
                      background: ColoredBox(
                        color: theme.colorScheme.onSecondary,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.check,
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                      secondaryBackground: ColoredBox(
                        color: theme.colorScheme.error,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.delete,
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          logger.d(
                              "Task '${taskStub[index]}' with index=$index is completed by dismission!");

                          completed.add(taskStub[index]);
                        } else {
                          logger.d(
                              "Task '${taskStub[index]}' with index=$index is deleted by dismission!");
                        }
                        setState(() {
                          taskStub.removeAt(index);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Checkbox.adaptive(
                              onChanged: (newValue) {
                                if (newValue != null && newValue) {
                                  logger.d(
                                      "Task '${taskStub[index]}' is completed by checkbox!");
                                  setState(() {
                                    completed.add(taskStub[index]);
                                    taskStub.removeAt(index);
                                  });
                                }
                              },
                              value: false,
                            ),
                            Expanded(
                              child: Text(
                                taskStub[index],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => NewToDoScreen(
                                    taskName: taskStub[index],
                                  ),
                                ),
                              ),
                              icon: Icon(
                                Icons.info_outline,
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: theme.colorScheme.secondary,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const NewToDoScreen(
                taskName: null,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;

  const _HeaderDelegate(this.title);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final viewButton = IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.visibility,
        color: colorScheme.primary,
      ),
    );
    final closedCount = Text(
      "Выполнено - 5",
      style: TextStyle(
        color: colorScheme.onPrimary,
        fontSize: 16,
      ),
      overflow: TextOverflow.ellipsis,
    );
    const limit = 100;
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isExpanded = constraints.maxHeight > limit;
        final closedRow = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (isExpanded) closedCount,
            viewButton,
          ],
        );
        final title = Text(
          "Мои дела",
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
                    mainAxisSize: MainAxisSize.max,
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
