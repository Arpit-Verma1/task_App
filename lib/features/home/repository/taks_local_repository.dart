import 'package:frontend/models/task_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TaksLocalRepository {
  String tableName = "tasks";

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "task.db");
    return openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute('''
        CREATE TABLE $tableName(
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        uid TEXT NOT NULL,
        color TEXT NOT NULL,
        deuAt TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
        )
        ''');
    });
  }

  Future<void> insertTask(TaskModel taskModel) async {
    final db = await database;
    await db.insert(tableName, taskModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertTasks(List<TaskModel> tasks) async {
    final db = await database;
    final batch = await db.batch();
    for (final task in tasks) {
      batch.insert(tableName, task.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  Future<List<TaskModel>> getTasks() async {
    final db = await database;
    final result = await db.query(tableName);
    if (result.isNotEmpty) {
      List<TaskModel> allTasks = [];
      for (var task in result) allTasks.add(TaskModel.fromJson(task));
      return allTasks;
    }
    return [];
  }
}
