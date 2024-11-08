import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class Task {
  @HiveField(1)
  String? taskId;
  @HiveField(2)
  int status;
  @HiveField(3)
  String name;
  @HiveField(4)
  int type;
  @HiveField(5)
  String? description;
  @HiveField(6)
  DateTime finishDate;
  @HiveField(7)
  bool urgent;
  @HiveField(8)
  String? file;

  Task({
    this.taskId,
    required this.status,
    required this.name,
    required this.type,
    this.description,
    required this.finishDate,
    required this.urgent,
    this.file,
  });
}