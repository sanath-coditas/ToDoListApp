import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/constants/text_constants.dart';
import 'package:todolist/constants/text_styles.dart';
import 'package:todolist/features/todoListApp/presentation/bloc/tasksbloc_bloc.dart';
import 'package:todolist/features/todoListApp/presentation/screens/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(kheadingText),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.filter_list_outlined)),
          BlocBuilder<TasksblocBloc, TasksblocState>(
            builder: (context, state) {
              return PopupMenuButton(
                itemBuilder: ((context) => [
                      const PopupMenuItem(
                        value: 1,
                        child: Text(kmarkAllText),
                      ),
                      const PopupMenuItem(
                        value: 2,
                        child: Text(kclearCompletedText),
                      ),
                    ]),
                onSelected: ((value) {
                  if (value == 1 && (state is LoadedState)) {
                    BlocProvider.of<TasksblocBloc>(context)
                        .add(MarkAllEvent(tasks: state.tasks));
                    BlocProvider.of<TasksblocBloc>(context)
                        .add(GetTasksEvent());
                  }
                  if (value == 2 && state is LoadedState) {
                    BlocProvider.of<TasksblocBloc>(context)
                        .add(DeleteSelectedEvent(tasks: state.tasks));
                    BlocProvider.of<TasksblocBloc>(context)
                        .add(GetTasksEvent());
                  }
                }),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTaskScreen()));
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.auto_graph), label: ''),
      ]),
      body: BlocBuilder<TasksblocBloc, TasksblocState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoadedState) {
            if (state.tasks.isEmpty) {
              return const Center(
                child: Text(
                  kemptyMessage,
                  style: kemptyTextStyle,
                ),
              );
            }
            return ListView.builder(
                itemCount: state.tasks.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    enabled: state.tasks[index].isDone ? false : true,
                    leading: Checkbox(
                        value: state.tasks[index].isDone,
                        onChanged: (val) {
                          BlocProvider.of<TasksblocBloc>(context)
                              .add(MarkAsDoneEvent(task: state.tasks[index]));
                          BlocProvider.of<TasksblocBloc>(context)
                              .add(GetTasksEvent());
                        }),
                    title: Text(
                      state.tasks[index].title,
                      style: state.tasks[index].isDone
                          ? kcompletedTextStyle
                          : null,
                    ),
                    subtitle: Text(
                      state.tasks[index].note,
                      style: state.tasks[index].isDone
                          ? kcompletedTextStyle
                          : null,
                    ),
                  );
                }));
          }
          if (state is ErrorState) {
            return Center(
              child: Text(state.message.toString()),
            );
          }
          return Container();
        },
      ),
    );
  }
}
