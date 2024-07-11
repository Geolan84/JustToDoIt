import 'package:sqflite/sqflite.dart';
import 'package:to_do/core/domain/task/task.dart';

/// Interface for app database data providers.
abstract interface class IDatabaseDataProvider {
  /// Initialization of database.
  Future<void> initDb();

  /// Inserts the task into the database.
  Future<bool> addTask(Task task);
}

/// Data provider for database.
class DatabaseDataProvider implements IDatabaseDataProvider {
  late final Database _database;

  @override
  Future<void> initDb() async {
    _database =
        await openDatabase('tasks.db', version: 1, onCreate: (db, version) {
      _database
        ..execute(
          _DatabaseConstants.initTasks,
        )
        ..execute(
          _DatabaseConstants.initRevision,
        );
    });
  }

  @override
  Future<bool> addTask(Task task) async {
    final pastedCount = await _database.insert(
      _DatabaseConstants.tasksTable,
      task.toJson(),
    );
    return pastedCount == 1;
  }
}

class _DatabaseConstants {
  static const tasksTable = 'tasks';
  static const revisionTable = 'revision';

  static const initTasks = '''
CREATE TABLE IF NOT EXISTS $tasksTable
(id TEXT PRIMARY KEY, 'text TEXT, importance TEXT,
done BOOLEAN NOT NULL, deadline INTEGER,
createdAt INTEGER, updatedAt INTEGER, lastUpdatedBy TEXT);
''';

  static const initRevision = '''
CREATE TABLE IF NOT EXISTS $revisionTable '
(id INTEGER PRIMARY KEY, revision INTEGER);
''';
}
