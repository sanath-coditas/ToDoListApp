part of 'tasksbloc_bloc.dart';

abstract class TasksblocEvent extends Equatable {
  const TasksblocEvent();

  @override
  List<Object> get props => [];
}

class InsertTaskEvent extends TasksblocEvent {
  final Task task;
  const InsertTaskEvent({required this.task});
}

class DeleteTaskEvent extends TasksblocEvent {
  final String id;
  const DeleteTaskEvent({required this.id});
}

class GetTasksEvent extends TasksblocEvent {}

class MarkAsDoneEvent extends TasksblocEvent {
  final Task task;
  const MarkAsDoneEvent({required this.task});
}

class MarkAllEvent extends TasksblocEvent {
  final List<Task> tasks;
  const MarkAllEvent({required this.tasks});
}

class DeleteSelectedEvent extends TasksblocEvent {
  final List<Task> tasks;
  const DeleteSelectedEvent({required this.tasks});
}
