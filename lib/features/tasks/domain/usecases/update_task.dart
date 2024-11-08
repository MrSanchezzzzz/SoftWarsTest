
import '../../../../core/usecases/usecase.dart';
import '../models/task.dart';

class UpdateTask extends UseCase<void,UpdateTaskParams>{
  UpdateTask({required super.repository});

  @override
  Future<void> call(UpdateTaskParams params) async{
    params.newTask.taskId=params.oldTask.taskId;
    await repository.postTask(params.newTask);
  }

}

class UpdateTaskParams{
  final Task oldTask;
  final Task newTask;
  UpdateTaskParams({required this.oldTask,required this.newTask});
}
