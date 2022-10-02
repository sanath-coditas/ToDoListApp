import 'package:get_it/get_it.dart';
import 'package:todolist/database_helper.dart';
import 'package:todolist/features/todoListApp/data/datasources/todolist_sqflite_datasource.dart';
import 'package:todolist/features/todoListApp/data/repositories/todolist_repository_impl.dart';
import 'package:todolist/features/todoListApp/domain/repository/todolist_repository.dart';
import 'package:todolist/features/todoListApp/domain/usecases/delete_selected_tasks_usecase.dart';
import 'package:todolist/features/todoListApp/domain/usecases/fetch_tasks_usecase.dart';
import 'package:todolist/features/todoListApp/domain/usecases/insert_into_database_usecase.dart';
import 'package:todolist/features/todoListApp/domain/usecases/mark_all_usecase.dart';
import 'package:todolist/features/todoListApp/domain/usecases/update_task_usecase.dart';
import 'package:todolist/features/todoListApp/presentation/bloc/tasksbloc_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! For bloc
  sl.registerFactory<TasksblocBloc>(() => TasksblocBloc(
        deleteTasksUseCase: sl(),
        fetchTasksUseCase: sl(),
        insertIntoDataBaseUsecase: sl(),
        updateTaskUsecase: sl(),
        markAllUsecase: sl(),
      ));

  // ! Usecases
  sl.registerLazySingleton<DeleteSelectedTasksUseCase>(
      () => DeleteSelectedTasksUseCase(taskRepository: sl()));
  sl.registerLazySingleton<InsertIntoDataBaseUsecase>(
      () => InsertIntoDataBaseUsecase(taskRepository: sl()));
  sl.registerLazySingleton<FetchTasksUseCase>(
      () => FetchTasksUseCase(taskRepository: sl()));
  sl.registerLazySingleton<UpdateTaskUsecase>(
      () => UpdateTaskUsecase(taskRepository: sl()));
  sl.registerLazySingleton<MarkAllUsecase>(
      () => MarkAllUsecase(taskRepository: sl()));

  //! Repositories
  sl.registerLazySingleton<TodoListRepository>(
      () => TodoListRepositoryImpl(todoListSQFLiteDataSource: sl()));

  //!DataSources
  sl.registerLazySingleton<TodoListSQFLiteDataSource>(
      () => TodoListSQFLiteDataSourceImpl(dataBaseHelper: sl()));

  sl.registerFactory<DataBaseHelper>(() => DataBaseHelper.instance);
}
