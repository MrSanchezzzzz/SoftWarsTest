import 'package:soft_wars_test/features/tasks/data/models/task_model.dart';

abstract class TaskRemoteDataSource{


  Future<List<TaskModel>> getAllTasks();
  Future<void> postTask(List<TaskModel> tasks);
  Future<void> putTask(String taskId,int status);
  Future<void> deleteTask(String taskId);
}