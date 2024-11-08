import 'package:soft_wars_test/features/tasks/data/models/task_model.dart';
import 'package:soft_wars_test/features/tasks/data/sources/task_local_data_source.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskLocalDataSourceImpl
    implements TaskLocalDataSource {
  @override
  Future<void> deleteTask(String taskId) async {
    Box<TaskModel> box =
        Hive.box<TaskModel>('taskModelsBox');
    final keyToDelete = box.keys.firstWhere(
      (key) => box.get(key)?.taskId == taskId,
      orElse: () => null,
    );

    if (keyToDelete != null) {
      await box.delete(keyToDelete);
    }
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    Box<TaskModel> box =
        Hive.box<TaskModel>('taskModelsBox');
    return box.values.toList();
  }

  @override
  Future<void> postTask(TaskModel task) async {
    Box<TaskModel> box =
        Hive.box<TaskModel>('taskModelsBox');
    box.add(task);
  }

  @override
  Future<void> putTask(
      String taskId, TaskModel newTask) async {
    Box<TaskModel> box =
        Hive.box<TaskModel>('taskModelsBox');
    final keyToUpdate = box.keys.firstWhere(
      (key) => box.get(key)?.taskId == taskId,
      orElse: () => null,
    );

    if (keyToUpdate != null) {
      await box.put(keyToUpdate, newTask);
    }
  }
}
