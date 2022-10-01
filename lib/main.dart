import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todolist/constants/color_constants.dart';
import 'package:todolist/features/todoListApp/presentation/screens/homescreen.dart';
import 'injection_container.dart' as di;
import 'features/todoListApp/presentation/bloc/tasksbloc_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return GetIt.instance<TasksblocBloc>()..add(GetTasksEvent());
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: kprimaryColor),
        home: const HomeScreen(),
      ),
    );
  }
}
