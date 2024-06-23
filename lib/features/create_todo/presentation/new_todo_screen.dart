import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

enum _Priority {
  no,
  low,
  high;

  @override
  String toString() {
    return switch (this) { no => "Нет", low => "Низкий", high => "!! Высокий" };
  }
}

class NewToDoScreen extends StatefulWidget {
  final String? taskName;

  const NewToDoScreen({required this.taskName, super.key});

  @override
  State<NewToDoScreen> createState() => _NewToDoScreenState();
}

class _NewToDoScreenState extends State<NewToDoScreen> {
  DateTime? selectedDate;

  _Priority priority = _Priority.no;

  final textController = TextEditingController();

  final logger = Logger();

  @override
  void initState() {
    super.initState();
    textController.text = widget.taskName ?? "";
  }

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Padding(
              padding: EdgeInsets.only(right: 5),
              child: Text(
                "СОХРАНИТЬ",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              child: Column(
                children: [
                  TextField(
                    textAlignVertical: TextAlignVertical.top,
                    controller: textController,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Что надо сделать...",
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: PopupMenuButton<_Priority>(
                        initialValue: _Priority.no,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Важность",
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              priority.toString(),
                              style:
                                  TextStyle(color: theme.colorScheme.onPrimary),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        onSelected: (value) => setState(() {
                          priority = value;
                        }),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: _Priority.no,
                            child: Text(
                              _Priority.no.toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          PopupMenuItem(
                            value: _Priority.low,
                            child: Text(
                              _Priority.low.toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          PopupMenuItem(
                            value: _Priority.high,
                            child: Text(
                              _Priority.high.toString(),
                              style: TextStyle(
                                color: theme.colorScheme.error,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(thickness: 0.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Сделать до",
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (selectedDate != null)
                            Text(
                              DateFormat(
                                'd MMMM',
                              ).format(
                                selectedDate!,
                              ),
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            )
                        ],
                      ),
                      Switch.adaptive(
                          value: selectedDate != null,
                          onChanged: (newValue) {
                            if (newValue) {
                              _selectDate(context);
                            } else {
                              setState(() {
                                selectedDate = null;
                              });
                            }
                          })
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(thickness: 0.5),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                  color: theme.colorScheme.error,
                ),
                Text(
                  "Удалить",
                  style: TextStyle(
                    color: theme.colorScheme.error,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }
}
