import 'package:todolist/error/failure.dart';
import 'package:todolist/features/todoListApp/data/models/task_model.dart';

import '../../domain/entities/task.dart';
import 'package:sqflite/sqflite.dart';

abstract class TodoListSQFLiteDataSource {
  Future<List<TaskModel>> getTasks();
  Future<List<TaskModel>> deleteSelectedTasks(List<String> ids);
  Future<List<TaskModel>> insertTask(Task task);
  Future<List<TaskModel>> updateTask(String id);
  Future<List<TaskModel>> markAllTasks();
}

class TodoListSQFLiteDataSourceImpl implements TodoListSQFLiteDataSource {
  final Database database;
  TodoListSQFLiteDataSourceImpl({required this.database});
  @override
  Future<List<TaskModel>> deleteSelectedTasks(List<String> ids) async {
    int? count;
    await database.transaction((txn) async {
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
    List<Map<String, dynamic>> list = await database.transaction((txn) async {
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
    await database.transaction((txn) async {
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
    await database.transaction((txn) async {
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
    await database.transaction((txn) async {
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
