import 'package:equatable/equatable.dart';
import 'package:todolist/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todolist/features/todoListApp/domain/repository/todolist_repository.dart';
import 'package:todolist/features/todoListApp/domain/entities/task.dart'
    as task;
import 'package:todolist/usecases/usecase.dart';

class MarkAllUsecase implements Usecase<Type, MarkAllParams> {
  final TodoListRepository taskRepository;
  const MarkAllUsecase({required this.taskRepository});

  @override
  Future<Either<Failure, List<task.Task>>> call(MarkAllParams params) async {
    return await taskRepository.markAllTask();
  }
}

class MarkAllParams extends Equatable {
  const MarkAllParams();
  @override
  List<Object?> get props => [];
}
