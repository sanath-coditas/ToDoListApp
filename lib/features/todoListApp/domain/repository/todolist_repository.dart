import 'package:dartz/dartz.dart';
import 'package:todolist/error/failure.dart';
import 'package:todolist/features/todoListApp/domain/entities/task.dart'
    as task;

abstract class TodoListRepository {
  Future<Either<Failure, List<task.Task>>> getTasks();
  Future<Either<Failure, List<task.Task>>> insertTask(task.Task task);
  Future<Either<Failure, List<task.Task>>> deleteTask(List<String> ids);
  Future<Either<Failure, List<task.Task>>> updateTask(String id);
  Future<Either<Failure, List<task.Task>>> markAllTask();
}
