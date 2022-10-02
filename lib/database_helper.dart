import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/features/todoListApp/domain/entities/task.dart';
import 'package:todolist/features/todoListApp/data/models/task_model.dart';

import 'error/failure.dart';
import 'features/todoListApp/data/datasources/todolist_sqflite_datasource.dart';

class DataBaseHelper implements TodoListSQFLiteDataSource {
  static final DataBaseHelper instance = DataBaseHelper._init();
  static Database? _database;

  DataBaseHelper._init();
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getApplicationDocumentsDirectory();
    final path = '$dbPath$filePath';

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Task (id TEXT PRIMARY KEY, title TEXT, note TEXT,isDone BLOB)');
  }

  @override
  Future<List<TaskModel>> deleteSelectedTasks(List<String> ids) async {
    int? count;
    await _database!.transaction((txn) async {
      count = await txn.delete(
        'Task',
        where: 'id IN (${List.filled(ids.length, '?').join(',')})',
        whereArgs: ids,
      );
    });

    if (count != null) {
      return getTasks();
    } else {
      throw DeletionFailure(message: 'Failed to Delete...');
    }
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    final List<TaskModel> tasks = [];
    final db = await instance.database;
    List<Map<String, dynamic>> list = await db.transaction((txn) async {
      return await txn.rawQuery('SELECT * FROM Task');
    });
    for (var element in list) {
      tasks.add(TaskModel.fromJson(element));
    }
    return tasks;
  }

  @override
  Future<List<TaskModel>> insertTask(Task task) async {
    int? txnId;
    final db = await instance.database;
    await db.transaction((txn) async {
      txnId = await txn.rawInsert(
          'INSERT INTO Task(id,title,note,isDone) VALUES(?,?,?,?)',
          [task.id, task.title, task.note, task.isDone ? 1 : 0]);
    });
    if (txnId != null) {
      return getTasks();
    } else {
      throw InsertionFailure(message: 'Failed to Insert...');
    }
  }

  @override
  Future<List<TaskModel>> updateTask(String id) async {
    int? txnId;
    final db = await instance.database;
    await db.transaction((txn) async {
      txnId = await txn
          .rawUpdate('UPDATE Task SET isDone = ? WHERE id = ?', [1, id]);
    });
    if (txnId != null) {
      return getTasks();
    } else {
      throw UpdationFailure(message: 'Failed to Update...');
    }
  }

  @override
  Future<List<TaskModel>> markAllTasks() async {
    int? count;
    final db = await instance.database;
    await db.transaction((txn) async {
      count = await txn.update(
        'Task',
        {"isDone": 1},
      );
    });

    if (count != null) {
      return getTasks();
    } else {
      throw UpdationFailure(message: 'Failed to Update...');
    }
  }
}
