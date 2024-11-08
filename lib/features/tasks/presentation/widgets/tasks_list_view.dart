import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_wars_test/features/tasks/presentation/bloc/tabs/tab_qubit.dart';
import 'package:soft_wars_test/features/tasks/presentation/bloc/task_events.dart';
import 'package:soft_wars_test/features/tasks/presentation/widgets/task_list_item.dart';

import '../../domain/models/task.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_state.dart';

class TasksListView extends StatelessWidget {
  const TasksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
        builder: (BuildContext context, TaskState state) {
      if (state is TaskLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is TaskLoadedState) {
        return BlocBuilder<TabCubit, int>(
          builder: (BuildContext context, int tabState) {
            List<Task> tasks = state.tasks;
            if (tabState != 0) {
              tasks = tasks
                  .where((task) => task.type == tabState)
                  .toList();
            }
            return RefreshIndicator(
              onRefresh: ()async{
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    Task task = tasks[index];
                    return TaskListItem(task: task);
                  }),
            );
          },
        );
      } else if (state is TaskErrorState) {
        return Center(
          child: Text(state.message,
              style: const TextStyle(color: Colors.white)),
        );
      } else if (state is TaskInitialState) {
        context.read<TaskBloc>().add(LoadTasksEvent());
      }
      return const Center(
          child: Text(
        'No tasks found',
        style: TextStyle(color: Colors.white),
      ));
    });
  }
}
