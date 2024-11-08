
import 'package:soft_wars_test/core/usecases/usecase.dart';

import '../models/task.dart';

class ChangeTaskStatus extends UseCase<void,ChangeStatusParams>{
  ChangeTaskStatus({required super.repository});

  @override
  Future<void> call(ChangeStatusParams params) async{
    await repository.putTask(params.task, params.status);
  }
}

class ChangeStatusParams{
  final Task task;
  final int status;

  ChangeStatusParams({required this.task, required this.status});

}