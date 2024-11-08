import 'package:soft_wars_test/features/tasks/data/sources/task_local_data_source.dart';
import 'package:soft_wars_test/features/tasks/data/sources/task_remote_data_source.dart';
import 'package:soft_wars_test/features/tasks/domain/models/task.dart';
import 'package:soft_wars_test/features/tasks/domain/repositories/task_repository.dart';

import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;
  final TaskLocalDataSource localDataSource;
  final bool local;

  TaskRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      this.local = false});

  int lastId = 0;

  @override
  Future<void> deleteTask(Task task) async {
    if(!local) {
      await remoteDataSource.deleteTask(task.taskId!);
    }
    else{
      await localDataSource.deleteTask(task.taskId!);
    }
  }

  @override
  Future<List<Task>> getAllTasks() async {

    List<TaskModel> tasks = [];
    if (!local) {
      tasks = await remoteDataSource.getAllTasks();
    } else {
      tasks = await localDataSource.getAllTasks();
    }

    for (var taskModel in tasks) {
      int id = int.parse(taskModel.taskId!);
      if (id > lastId) {
        lastId = id;
      }
    }
    return tasks;
  }

  @override
  Future<void> postTask(Task task) async {
    TaskModel taskModel = TaskModel.fromTask(task);
    if (!local) {
      taskModel.taskId ??= (++lastId).toString();
      await remoteDataSource.postTask([taskModel]);
    } else {
      if (taskModel.taskId != null) {
        await localDataSource.putTask(taskModel.taskId!, taskModel);
      }else{
        taskModel.taskId ??= (++lastId).toString();
        await localDataSource.postTask(taskModel);
      }
    }
  }

  @override
  Future<void> putTask(Task task, int status) async {
    if(!local) {
      await remoteDataSource.putTask(task.taskId!, status);
    } else {
      TaskModel taskModel=TaskModel.fromTask(task);
      taskModel.status=status;
      await localDataSource.putTask(task.taskId!, taskModel);
    }
  }
}
