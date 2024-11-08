import 'package:soft_wars_test/features/tasks/domain/repositories/task_repository.dart';

abstract class UseCase<Type, Params> {
  final TaskRepository repository;
  UseCase({required this.repository});
  Future<Type> call(Params params);
}
class NoParams{}