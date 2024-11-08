import 'package:soft_wars_test/core/usecases/usecase.dart';
import '../models/task.dart';

class GetAllTasks extends UseCase<List<Task>,NoParams>{
  GetAllTasks({required super.repository});
  @override
  Future<List<Task>> call(NoParams params) async{
    List<Task> tasks = await repository.getAllTasks();
    tasks.sort((a, b) {
      if (a.urgent && !b.urgent) return -1;
      return 1;
    });
    return tasks;
  }

}