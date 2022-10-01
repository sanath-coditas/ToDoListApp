import 'package:equatable/equatable.dart';
import 'package:todolist/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todolist/features/todoListApp/domain/repository/todolist_repository.dart';
import 'package:todolist/usecases/usecase.dart';
import 'package:todolist/features/todoListApp/domain/entities/task.dart' as task;
class InsertIntoDataBaseUsecase implements Usecase<task.Task, Params> {
  final TodoListRepository taskRepository;
  const InsertIntoDataBaseUsecase({required this.taskRepository});
  @override
  Future<Either<Failure, List<task.Task>>> call(Params params) async {
    return await taskRepository.insertTask(params.taskParam);
  }
}

class Params extends Equatable {
  final task.Task taskParam;
  const Params({required this.taskParam});

  @override
  List<Object?> get props => [taskParam];
}
