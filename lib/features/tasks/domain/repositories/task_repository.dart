import '../models/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getAllTasks();
  Future<void> postTask(Task task);
  Future<void> putTask(Task task, int status);
  Future<void> deleteTask(Task task);

}