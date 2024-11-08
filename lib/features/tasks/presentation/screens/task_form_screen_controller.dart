import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../domain/models/task.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_events.dart';

class TaskFormScreenController {
  final TextEditingController titleController =
      TextEditingController();
  final TextEditingController descriptionController =
      TextEditingController();
  DateTime? finishDate;
  bool urgent = true;
  int type = 1;
  Uint8List? image;

  final Task? task;

  TaskFormScreenController(this.task) {
    if (task != null) {
      titleController.text = task!.name;
      descriptionController.text = task!.description ?? '';
      if (task!.file != null) {
        image = base64Decode(task!.file!);
      }
      setType(task!.type);
      setUrgent(task!.urgent);
      setFinishDate(task!.finishDate);
    }
  }

  void setFinishDate(DateTime? date) {
    finishDate = date;
  }

  void setType(int? value) {
    if (value != null) {
      type = value;
    }
  }

  void setUrgent(bool? value) {
    urgent = value ?? true;
  }

  String get formattedFinishDate {
    return finishDate != null
        ? DateFormat('dd.MM.yyyy').format(finishDate!)
        : '';
  }

  bool validateInputs(BuildContext context) {
    if (titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Назва завдання не може бути порожньою')),
      );
      return false;
    }

    if (finishDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Будь ласка, виберіть дату завершення')),
      );
      return false;
    }
    return true;
  }

  void createTask(BuildContext context) {
    if (!validateInputs(context)) return;

    String? fileBase64;
    if (image != null) {
      fileBase64 = base64Encode(image!);
    }

    final task = Task(
      name: titleController.text,
      status: 1,
      type: type,
      description: descriptionController.text,
      finishDate: finishDate!,
      urgent: urgent,
      file: fileBase64
    );

    context
        .read<TaskBloc>()
        .add(CreateTaskEvent(task: task));
    Navigator.of(context).pop();
  }

  void updateTask(BuildContext context) async {
    if (!validateInputs(context)) return;
    String? fileBase64;
    if (image != null) {
      fileBase64 = base64Encode(image!);
    }

    final newTask = Task(
        name: titleController.text,
        status: 1,
        type: type,
        description: descriptionController.text,
        finishDate: finishDate!,
        urgent: urgent,
        file: fileBase64);

    context.read<TaskBloc>().add(
        UpdateTaskEvent(oldTask: task!, newTask: newTask));
    Navigator.of(context).pop();
  }

  void deleteTask(BuildContext context, Task task) {
    context
        .read<TaskBloc>()
        .add(DeleteTaskEvent(task: task));
    Navigator.of(context).pop();
  }

  Future<void> setImage(XFile? xfile) async {
    if (xfile == null) {
      image = null;
      return;
    }
    final imageFile = File(xfile.path);
    image = await imageFile.readAsBytes();
  }
}
