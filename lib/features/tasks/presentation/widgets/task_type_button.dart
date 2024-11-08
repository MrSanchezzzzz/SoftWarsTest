
import 'package:flutter/material.dart';

class TaskTypeButton extends StatelessWidget {
  const TaskTypeButton({super.key,this.title,this.onTap});
  final String? title;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FilledButton(
          onPressed: onTap,
          child: Text(title??'')
      ),
    );
  }
}
