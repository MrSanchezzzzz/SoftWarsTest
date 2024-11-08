import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:soft_wars_test/features/tasks/presentation/bloc/task_events.dart';
import 'package:soft_wars_test/theme.dart';
import '../../domain/models/task.dart';
import '../bloc/task_bloc.dart';

class TaskListItem extends StatefulWidget {
  const TaskListItem({super.key, required this.task});

  final Task task;

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  late bool _checked;

  @override
  void initState() {
    super.initState();
    _checked = widget.task.status == 2;
  }

  @override
  void didUpdateWidget(covariant TaskListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.task.status != widget.task.status) {
      _checked = widget.task.status == 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.push('/task_form',extra: widget.task);
      },
      child: Card(
        color: widget.task.urgent ? ProjectColors.accentRed : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Icon(
                widget.task.type == 1 ? Icons.work_outline : Icons.home_outlined,
                size: 30,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    DateFormat('dd.MM.yyyy').format(widget.task.finishDate),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
              const Spacer(),
              Transform.scale(
                scale: 1.25,
                child: Checkbox(
                  value: _checked,
                  onChanged: (val) {
                    if (val == null) return;
                    setState(() {
                      _checked = val;
                    });
                    context.read<TaskBloc>().add(
                        ChangeTaskStatusEvent(task: widget.task, status: val ? 2 : 1));
                    widget.task.status = val ? 2 : 1;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
