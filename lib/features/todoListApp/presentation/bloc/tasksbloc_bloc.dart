import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todolist/error/failure.dart';
import 'package:todolist/features/todoListApp/domain/usecases/delete_selected_tasks_usecase.dart';
import 'package:todolist/features/todoListApp/domain/usecases/fetch_tasks_usecase.dart';
import 'package:todolist/features/todoListApp/domain/usecases/insert_into_database_usecase.dart'
    as itd;
import 'package:todolist/features/todoListApp/domain/usecases/mark_all_usecase.dart';
import 'package:todolist/features/todoListApp/domain/usecases/update_task_usecase.dart';

import '../../domain/entities/task.dart';

part 'tasksbloc_event.dart';
part 'tasksbloc_state.dart';

class TasksblocBloc extends Bloc<TasksblocEvent, TasksblocState> {
  final DeleteSelectedTasksUseCase deleteTasksUseCase;
  final FetchTasksUseCase fetchTasksUseCase;
  final itd.InsertIntoDataBaseUsecase insertIntoDataBaseUsecase;
  final UpdateTaskUsecase updateTaskUsecase;
  final MarkAllUsecase markAllUsecase;

  TasksblocBloc({
    required this.deleteTasksUseCase,
    required this.fetchTasksUseCase,
    required this.insertIntoDataBaseUsecase,
    required this.updateTaskUsecase,
    required this.markAllUsecase,
  }) : super((TasksblocInitial())) {
    on<GetTasksEvent>((event, emit) async {
      emit(LoadingState());
      final getEither = await fetchTasksUseCase(NoParams());
      getEither.fold((failure) {
        emit(ErrorState(message: failure));
      }, (tasks) => emit(LoadedState(tasks: tasks)));
    });

    on<InsertTaskEvent>((event, emit) async {
      final getInsertionStatus =
          await insertIntoDataBaseUsecase(itd.Params(taskParam: event.task));
      getInsertionStatus.fold((failure) {
        emit(ErrorState(message: failure));
      }, (tasks) => emit(LoadedState(tasks: tasks)));
    });

    on<MarkAsDoneEvent>((event, emit) async {
      final getUpdateStatusEither =
          await updateTaskUsecase(UpdateParams(id: event.task.id));
      getUpdateStatusEither.fold(
          (updatError) => emit(ErrorState(message: updatError)),
          (tasks) => emit(LoadedState(tasks: tasks)));
    });

    on<MarkAllEvent>((event, emit) async {
      final getUpdateAllEither = await markAllUsecase(const MarkAllParams());
      getUpdateAllEither.fold((error) => emit(ErrorState(message: error)),
          (list) => LoadedState(tasks: list));
    });

    on<DeleteSelectedEvent>((event, emit) async {
      List<String> doneTaskIds = [];
      for (Task taskItem in event.tasks) {
        if (taskItem.isDone) {
          doneTaskIds.add(taskItem.id);
        }
      }
      final getDeleteStatusEither =
          await deleteTasksUseCase(DeleteParams(ids: doneTaskIds));
      getDeleteStatusEither.fold((error) => ErrorState(message: error),
          (list) => emit(LoadedState(tasks: list)));
    });
  }
}
