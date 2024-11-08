import '../../domain/models/task.dart';

abstract class TaskEvent {}

class LoadTasksEvent extends TaskEvent {}
class CreateTaskEvent extends TaskEvent {
  final Task task;
  CreateTaskEvent({required this.task});
}
class UpdateTaskEvent extends TaskEvent {
  final Task oldTask;
  final Task newTask;
  UpdateTaskEvent({required this.oldTask, required this.newTask});
}
class DeleteTaskEvent extends TaskEvent {
  final Task task;
  DeleteTaskEvent({required this.task});
}

class ChangeTaskStatusEvent extends TaskEvent {
  final Task task;
  final int status;
  ChangeTaskStatusEvent({required this.task, required this.status});
}