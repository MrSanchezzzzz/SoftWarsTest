import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_wars_test/core/usecases/usecase.dart';
import 'package:soft_wars_test/features/tasks/data/sources/task_local_data_source.dart';
import 'package:soft_wars_test/features/tasks/data/sources/task_remote_data_source_impl.dart';
import 'package:soft_wars_test/features/tasks/domain/usecases/change_task_status.dart';
import 'package:soft_wars_test/features/tasks/domain/usecases/create_task.dart';
import 'package:soft_wars_test/features/tasks/domain/usecases/get_all_tasks.dart';
import 'package:soft_wars_test/features/tasks/domain/usecases/update_task.dart';
import 'package:soft_wars_test/features/tasks/presentation/bloc/task_events.dart';
import '../../data/repositories/task_repository_impl.dart';
import '../../data/sources/task_local_data_source_impl.dart';
import '../../data/sources/task_remote_data_source.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/usecases/delete_task.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  late final GetAllTasks getAllTasks;
  late final DeleteTask deleteTask;
  late final UpdateTask updateTask;
  late final CreateTask createTask;
  late final ChangeTaskStatus changeTaskStatus;

  TaskBloc() : super(TaskInitialState()) {

    TaskRemoteDataSource remoteDataSource=TaskRemoteDataSourceImpl(email: 'kremenchuksh@gmail.com');
    TaskLocalDataSource localDataSource=TaskLocalDataSourceImpl();
    TaskRepository taskRepository=TaskRepositoryImpl(
        remoteDataSource: remoteDataSource,
        localDataSource: localDataSource,
      local: true
    );
    createTask=CreateTask(repository: taskRepository);
    getAllTasks=GetAllTasks(repository: taskRepository);
    updateTask=UpdateTask(repository: taskRepository);
    deleteTask=DeleteTask(repository: taskRepository);
    changeTaskStatus=ChangeTaskStatus(repository: taskRepository);

    on<LoadTasksEvent>(_onLoadTasks);
    on<CreateTaskEvent>(_onCreateTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<ChangeTaskStatusEvent>(_onChangeTaskStatus);
  }

  Future<void> _onLoadTasks(
      LoadTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      final tasks = await getAllTasks.call(NoParams());
      emit(TaskLoadedState(tasks));
    } catch (e) {
      emit(TaskErrorState("Failed to load tasks"));
    }
  }

  // Add a new task
  Future<void> _onCreateTask(
      CreateTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await createTask.call(event.task);
      emit(TaskCreated(event.task));
      add(LoadTasksEvent());
    } catch (e) {
      emit(TaskErrorState("Failed to add task"));
    }
  }

  // Update an existing task
  Future<void> _onUpdateTask(
      UpdateTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await updateTask.call(UpdateTaskParams(oldTask: event.oldTask, newTask: event.newTask));
      emit(TaskUpdatedState(event.newTask));
      add(LoadTasksEvent()); // Reload tasks to show updated list
    } catch (e) {
      emit(TaskErrorState("Failed to update task"));
    }
  }

  Future<void> _onDeleteTask(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await deleteTask.call(event.task);
      emit(TaskDeletedState(event.task));
      add(LoadTasksEvent()); // Reload tasks to show updated list
    } catch (e) {
      emit(TaskErrorState("Failed to delete task"));
    }
  }

  Future<void> _onChangeTaskStatus(
      ChangeTaskStatusEvent event, Emitter<TaskState> emit) async {
    try {
      final params=ChangeStatusParams(task: event.task, status: event.status);
      await changeTaskStatus.call(params);
    } catch (e) {
      emit(TaskErrorState("Failed to change task status"));
    }
  }
}
