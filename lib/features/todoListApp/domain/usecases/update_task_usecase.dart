import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todolist/error/failure.dart';
import 'package:todolist/usecases/usecase.dart';
import 'package:todolist/features/todoListApp/domain/entities/task.dart' as task;
import 'package:todolist/features/todoListApp/domain/repository/todolist_repository.dart';




class UpdateTaskUsecase implements Usecase<task.Task,UpdateParams>{

  final TodoListRepository taskRepository;
  UpdateTaskUsecase({required this.taskRepository});
  @override
  Future<Either<Failure, List<task.Task>>> call(UpdateParams params) async {
     return await taskRepository.updateTask(params.id);
  }


}
class UpdateParams extends Equatable {
  final String id;
  const UpdateParams({required this.id});
  @override
  List<Object?> get props => [id];
}