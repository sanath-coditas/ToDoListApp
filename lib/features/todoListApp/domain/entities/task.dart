import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String note;
  final bool isDone;

   const Task(
      {required this.id,
      required this.title,
      required this.note,
      required this.isDone});

  @override
  List<Object?> get props => [id, title, note, isDone];


}
