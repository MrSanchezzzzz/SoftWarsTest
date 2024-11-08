
import '../../../../core/usecases/usecase.dart';
import '../models/task.dart';

class CreateTask extends UseCase<void,Task>{
  CreateTask({required super.repository});

  @override
  Future<void> call(params) async{
    await repository.postTask(params);
  }

}