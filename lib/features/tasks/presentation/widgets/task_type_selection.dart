import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_wars_test/features/tasks/presentation/bloc/tabs/tab_qubit.dart';
import 'package:soft_wars_test/features/tasks/presentation/widgets/task_type_button.dart';

class TaskTypeSelection extends StatelessWidget {
  const TaskTypeSelection({super.key});

  void selectTab(BuildContext context,int index)=>
      context.read<TabCubit>().selectTab(index);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabCubit,int>(
      builder: (BuildContext context, int index) {
        return Row(mainAxisSize: MainAxisSize.max, children: [
          TaskTypeButton(
            title: 'Усі',
            onTap: index!=0?(){
              selectTab(context, 0);
            }:null,
          ),
          const SizedBox(
            width: 8,
          ),
          TaskTypeButton(
            title: 'Робочі',
            onTap: index!=1?(){
              selectTab(context, 1);
            }:null,
          ),
          const SizedBox(
            width: 8,
          ),
          TaskTypeButton(
            title: 'Особисті',
            onTap: index!=2?(){
              selectTab(context, 2);
            }:null,
          ),
        ]);
      },
    );
  }
}
