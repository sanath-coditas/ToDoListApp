import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/constants/text_constants.dart';
import 'package:todolist/features/todoListApp/domain/entities/task.dart';
import 'package:todolist/features/todoListApp/presentation/bloc/tasksbloc_bloc.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  String? _validator(String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kaddNoteText),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextFormField(
                controller: _textEditingController1,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: _validator,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextFormField(
                controller: _textEditingController2,
                validator: _validator,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Note',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            BlocProvider.of<TasksblocBloc>(context).add(InsertTaskEvent(
                task: Task(
                    id: DateTime.now().toString(),
                    title: _textEditingController1.text,
                    note: _textEditingController2.text,
                    isDone: false)));
            BlocProvider.of<TasksblocBloc>(context).add(GetTasksEvent());
            Navigator.of(context).pop();
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
