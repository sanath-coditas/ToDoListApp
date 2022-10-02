import 'package:todolist/database_helper.dart';
import 'package:todolist/features/todoListApp/data/models/task_model.dart';

import '../../domain/entities/task.dart';

abstract class TodoListSQFLiteDataSource {
  Future<List<TaskModel>> getTasks();
  Future<List<TaskModel>> deleteSelectedTasks(List<String> ids);
  Future<List<TaskModel>> insertTask(Task task);
  Future<List<TaskModel>> updateTask(String id);
  Future<List<TaskModel>> markAllTasks();
}

class TodoListSQFLiteDataSourceImpl implements TodoListSQFLiteDataSource {
  final DataBaseHelper dataBaseHelper;
  TodoListSQFLiteDataSourceImpl({required this.dataBaseHelper});
  @override
  Future<List<TaskModel>> deleteSelectedTasks(List<String> ids) async {
    return await dataBaseHelper.deleteSelectedTasks(ids);
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    return await dataBaseHelper.getTasks();
  }

  @override
  Future<List<TaskModel>> insertTask(Task task) async {
    return await dataBaseHelper.insertTask(task);
  }

  @override
  Future<List<TaskModel>> updateTask(String id) async {
    return await dataBaseHelper.updateTask(id);
  }

  @override
  Future<List<TaskModel>> markAllTasks() async {
    return await dataBaseHelper.markAllTasks();
  }
}
