import 'package:go_router/go_router.dart';
import 'package:soft_wars_test/features/tasks/presentation/screens/task_form_screen.dart';

import 'features/authorization/presentation/screens/authorization_screen.dart';
import 'features/tasks/domain/models/task.dart';
import 'features/tasks/presentation/screens/tasks_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/authorization',
  routes: [
    GoRoute(
      path: '/',
      redirect: (context,state){
        //TODO check if user logged
        return null;
      },
      builder: (context, state) =>
      const TasksScreen(),
      routes: [
        GoRoute(
            path: 'authorization',
            builder: (context, state) =>
                const AuthorizationScreen()
        ),
        GoRoute(
            path: 'task_form',
            builder: (context,state){
              Task? task;
              if(state.extra!=null){
                task=state.extra as Task;
              }
              return TaskFormScreen(task: task,);
            }
        ),
      ]
    ),
  ],
);