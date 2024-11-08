import 'package:hive_flutter/adapters.dart';

import '../../domain/models/task.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends Task {
  @HiveField(0)
  final String? id;
  @HiveField(9)
  final DateTime? syncTime;

  TaskModel({
    this.id,
    required super.taskId,
    required super.status,
    required super.name,
    required super.type,
    super.description,
    required super.finishDate,
    required super.urgent,
    this.syncTime,
    super.file,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskId: json['taskId'],
      status: json['status'],
      name: json['name'],
      type: json['type'],
      description: json['description'],
      finishDate: DateTime.parse(json['finishDate']),
      urgent: json['urgent'] == 1,
      syncTime: DateTime.parse(json['syncTime']),
      file: json['file'],
    );
  }

  factory TaskModel.fromTask(Task task) {
    return TaskModel(
      taskId: task.taskId,
      status: task.status,
      name: task.name,
      type: task.type,
      finishDate: task.finishDate,
      urgent: task.urgent,
      description: task.description,
      file: task.file,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskId': taskId,
      'status': status,
      'name': name,
      'type': type,
      'description': description,
      'finishDate': finishDate.toIso8601String(),
      'urgent': urgent ? 1 : 0,
      'syncTime': syncTime?.toIso8601String(),
      'file': file,
    };
  }

  Map<String, dynamic> diff(TaskModel other) {
    final Map<String, dynamic> diff = {};
    if (status != other.status) {
      diff['status'] = other.status;
    }
    if (name != other.name) diff['name'] = other.name;
    if (type != other.type) diff['type'] = other.type;
    if (description != other.description) {
      diff['description'] = other.description;
    }
    if (finishDate != other.finishDate) {
      diff['finishDate'] = other.finishDate;
    }
    if (urgent != other.urgent) {
      diff['urgent'] = other.urgent;
    }
    if (syncTime != other.syncTime) {
      diff['syncTime'] = other.syncTime;
    }
    if (file != other.file) diff['file'] = other.file;
    return diff;
  }

  TaskModel copyWith({
    String? taskId,
    int? status,
    String? name,
    int? type,
    String? description,
    DateTime? finishDate,
    bool? urgent,
    DateTime? syncTime,
    String? file,
  }) {
    return TaskModel(
      taskId: taskId ?? this.taskId,
      status: status ?? this.status,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      finishDate: finishDate ?? this.finishDate,
      urgent: urgent ?? this.urgent,
      syncTime: syncTime ?? this.syncTime,
      file: file ?? this.file,
    );
  }
}
