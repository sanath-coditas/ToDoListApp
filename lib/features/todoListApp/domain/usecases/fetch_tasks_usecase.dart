import 'package:equatable/equatable.dart';
import 'package:todolist/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todolist/features/todoListApp/domain/repository/todolist_repository.dart';
import 'package:todolist/usecases/usecase.dart';
import 'package:todolist/features/todoListApp/domain/entities/task.dart' as task;

class FetchTasksUseCase implements Usecase<Task, NoParams> {
  final TodoListRepository taskRepository;
  const FetchTasksUseCase({required this.taskRepository});
  @override
  Future<Either<Failure, List<task.Task>>> call(NoParams noParams) async {
    return await taskRepository.getTasks();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
