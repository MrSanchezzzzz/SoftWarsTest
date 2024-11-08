import '../../domain/models/task.dart';

abstract class TaskState {}

class TaskInitialState extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskLoadedState extends TaskState {
  final List<Task> tasks;

  TaskLoadedState(this.tasks);
}

// State when a task is successfully added
class TaskCreated extends TaskState {
  final Task task;

  TaskCreated(this.task);
}

class TaskUpdatedState extends TaskState {
  final Task newTask;

  TaskUpdatedState(this.newTask);
}


class TaskDeletedState extends TaskState {
  final Task task;

  TaskDeletedState(this.task);
}

class TaskErrorState extends TaskState {
  final String message;

  TaskErrorState(this.message);
}
