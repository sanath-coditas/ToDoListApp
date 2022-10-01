import 'package:todolist/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todolist/features/todoListApp/data/datasources/todolist_sqflite_datasource.dart';
import 'package:todolist/features/todoListApp/domain/repository/todolist_repository.dart';
import 'package:todolist/features/todoListApp/domain/entities/task.dart'
    as task;

class TodoListRepositoryImpl implements TodoListRepository {
  final TodoListSQFLiteDataSource todoListSQFLiteDataSource;
  const TodoListRepositoryImpl({required this.todoListSQFLiteDataSource});
  @override
  Future<Either<Failure, List<task.Task>>> deleteTask(List<String> ids) async {
    try {
      await todoListSQFLiteDataSource.deleteSelectedTasks(ids);
      final List<task.Task> tasks = await todoListSQFLiteDataSource.getTasks();
      return Right(tasks);
    } on DeletionFailure {
      return Left(DeletionFailure(message: 'Deletion Failed'));
    }
  }

  @override
  Future<Either<Failure, List<task.Task>>> getTasks() async {
    try {
      final List<task.Task> tasks = await todoListSQFLiteDataSource.getTasks();
      return Right(tasks);
    } on FetchFailure {
      return Left(FetchFailure(message: 'Failed to fetch.....'));
    }
  }

  @override
  Future<Either<Failure, List<task.Task>>> insertTask(
      task.Task taskTobeInserted) async {
    try {
      await todoListSQFLiteDataSource.insertTask(taskTobeInserted);
      final List<task.Task> tasks = await todoListSQFLiteDataSource.getTasks();
      return Right(tasks);
    } on InsertionFailure {
      return Left(InsertionFailure(message: 'Failed to Insert.....'));
    }
  }

  @override
  Future<Either<Failure, List<task.Task>>> updateTask(String id) async {
    try {
      await todoListSQFLiteDataSource.updateTask(id);
      final List<task.Task> tasks = await todoListSQFLiteDataSource.getTasks();
      return Right(tasks);
    } on UpdationFailure {
      return Left(UpdationFailure(message: 'Failed to Update.....'));
    }
  }

  @override
  Future<Either<Failure, List<task.Task>>> markAllTask() async {
    try {
      await todoListSQFLiteDataSource.markAllTasks();
      final List<task.Task> tasks = await todoListSQFLiteDataSource.getTasks();
      return Right(tasks);
    } on UpdationFailure {
      return Left(UpdationFailure(message: 'Failed to mark all.....'));
    }
  }
}
