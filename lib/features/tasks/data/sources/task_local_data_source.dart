import 'package:soft_wars_test/features/tasks/data/models/task_model.dart';

abstract class TaskLocalDataSource {

  Future<List<TaskModel>> getAllTasks();
  Future<void> postTask(TaskModel task);
  Future<void> putTask(String taskId, TaskModel newTask);
  Future<void> deleteTask(String taskId);
}