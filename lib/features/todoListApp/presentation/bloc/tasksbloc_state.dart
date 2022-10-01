part of 'tasksbloc_bloc.dart';

abstract class TasksblocState extends Equatable {
  const TasksblocState();

  @override
  List<Object> get props => [];
}

class TasksblocInitial extends TasksblocState {}

class LoadingState extends TasksblocState {}

class LoadedState extends TasksblocState {
  final List<Task> tasks;
  const LoadedState({required this.tasks});
}

class ErrorState extends TasksblocState {
  final Failure message;
  const ErrorState({required this.message});
}
