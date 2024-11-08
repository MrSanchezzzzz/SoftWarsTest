import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soft_wars_test/theme.dart';
import '../../domain/models/task.dart';
import '../widgets/custom_radio.dart';
import '../widgets/input_container.dart';
import 'task_form_screen_controller.dart';

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key, this.task});

  final Task? task;

  @override
  State<TaskFormScreen> createState() =>
      _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  late final TaskFormScreenController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TaskFormScreenController(widget.task);
  }

  @override
  void dispose() {
    _controller.titleController.dispose();
    _controller.descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectFinishDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    setState(() {
      _controller.setFinishDate(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Назва завдання...',
                      hintStyle: TextStyle(fontSize: 24),
                    ),
                    controller: _controller.titleController,
                    style: const TextStyle(
                        fontSize: 24, color: Colors.white),
                  ),
                ),
                if (widget.task != null) ...{
                  const SizedBox(
                    width: 4,
                  ),
                  IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () {
                      _controller.updateTask(context);
                    },
                  ),
                }
              ],
            ),
            InputContainer(
              child: Row(
                children: <Widget>[
                  CustomRadio(
                    value: 1,
                    groupValue: _controller.type,
                    onChanged: (value) => setState(
                        () => _controller.setType(value)),
                    label: 'Робочі',
                  ),
                  const SizedBox(width: 90),
                  CustomRadio(
                    value: 2,
                    groupValue: _controller.type,
                    onChanged: (value) => setState(
                        () => _controller.setType(value)),
                    label: 'Особисті',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            InputContainer(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Додати опис...',
                  hintStyle: TextStyle(
                      fontSize: 16, color: Colors.white),
                ),
                controller:
                    _controller.descriptionController,
                minLines: 5,
                maxLines: 5,
              ),
            ),
            const SizedBox(height: 8),
            InputContainer(
              child: GestureDetector(
                onTap: () async {
                  final image = await ImagePicker()
                      .pickImage(
                          source: ImageSource.gallery);
                  await _controller.setImage(image);
                  setState(() {});
                },
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Прикріпити файл:',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge,
                    ),
                    if (_controller.image != null) ...{
                      const SizedBox(
                        height: 4,
                      ),
                      Stack(
                        children: [
                          Image.memory(
                            _controller.image!,
                            width: MediaQuery.of(context)
                                .size
                                .width,
                            fit: BoxFit.fill,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _controller
                                        .setImage(null);
                                  });
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: (Theme.of(context)
                                              .iconTheme
                                              .size ??
                                          16) *
                                      2,
                                )),
                          )
                        ],
                      )
                    }
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            InputContainer(
              child: GestureDetector(
                onTap: _selectFinishDate,
                child: Text(
                  'Дата завершення: ${_controller.formattedFinishDate}',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),
              ),
            ),
            const SizedBox(height: 8),
            InputContainer(
              child: Row(
                children: <Widget>[
                  Checkbox(
                    value: _controller.urgent,
                    onChanged: (value) => setState(
                        () => _controller.setUrgent(value)),
                    materialTapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                  ),
                  const SizedBox(width: 4.5),
                  Text(
                    'Термінове',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: widget.task != null
                        ? ProjectColors.accentRed
                        : null),
                onPressed: () {
                  if (widget.task != null) {
                    _controller.deleteTask(
                        context, widget.task!);
                  } else {
                    _controller.createTask(context);
                  }
                },
                child: Text(widget.task != null
                    ? 'Видалити'
                    : 'Створити'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
