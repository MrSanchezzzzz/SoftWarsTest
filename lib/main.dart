import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:soft_wars_test/features/tasks/data/models/task_model.dart';
import 'package:soft_wars_test/router.dart';
import 'package:soft_wars_test/theme.dart';
import 'features/tasks/presentation/bloc/task_bloc.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('taskModelsBox');
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<TaskBloc>(
        create: (context) => TaskBloc(),
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: defaultTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        ),
      ),
    );
  }
}
