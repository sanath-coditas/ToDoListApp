import 'package:equatable/equatable.dart';
import 'package:todolist/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todolist/features/todoListApp/domain/repository/todolist_repository.dart';
import 'package:todolist/features/todoListApp/domain/entities/task.dart'
    as task;
import 'package:todolist/usecases/usecase.dart';

class DeleteSelectedTasksUseCase implements Usecase<Type, DeleteParams> {
  final TodoListRepository taskRepository;
  const DeleteSelectedTasksUseCase({required this.taskRepository});

  @override
  Future<Either<Failure, List<task.Task>>> call(DeleteParams params) async {
    return await taskRepository.deleteTask(params.ids);
  }
}

class DeleteParams extends Equatable {
  final List<String> ids;
  const DeleteParams({required this.ids});

  @override
  List<Object?> get props => [ids];
}
