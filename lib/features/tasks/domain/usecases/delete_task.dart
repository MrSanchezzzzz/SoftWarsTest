
import '../../../../core/usecases/usecase.dart';
import '../models/task.dart';

class DeleteTask extends UseCase<void,Task>{
  DeleteTask({required super.repository});

  @override
  Future<void> call(params) async{
    await repository.deleteTask(params);
  }

}