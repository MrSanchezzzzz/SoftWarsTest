import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soft_wars_test/features/tasks/presentation/bloc/tabs/tab_qubit.dart';
import 'package:soft_wars_test/features/tasks/presentation/widgets/task_type_selection.dart';
import 'package:soft_wars_test/features/tasks/presentation/widgets/tasks_list_view.dart';


class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TabCubit>(create: (context) => TabCubit(),),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
          body: const Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TaskTypeSelection(),
                SizedBox(height: 24,),
                Expanded(child: TasksListView())
              ],
            ),
          ),
        floatingActionButton: FloatingActionButton(
            onPressed: (){
              context.push('/task_form');
            },
          child: const Icon(Icons.add,),
        ),
      ),
    );
  }
}
