import 'package:todolist/features/todoListApp/domain/entities/task.dart';

class TaskModel extends Task {
  final String modelId;
  final String modelTitle;
  final String modelNote;
  final bool modelIsDone;

  const TaskModel(
      {required this.modelId,
      required this.modelTitle,
      required this.modelNote,
      required this.modelIsDone})
      : super(
            id: modelId,
            title: modelTitle,
            note: modelNote,
            isDone: modelIsDone);

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      modelId: json['id'],
      modelTitle: json['title'],
      modelNote: json['note'],
      modelIsDone: (json['isDone'] == 0) ? false : true,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': modelId,
      'title': modelTitle,
      'note': modelNote,
      'isDone': modelIsDone,
    };
    return map;
  }
}
