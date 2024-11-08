import 'package:flutter/material.dart';

import '../../../../theme.dart';

class CustomRadio<T> extends StatelessWidget {
  const CustomRadio(
      {super.key,
      this.value,
      this.groupValue,
      this.onChanged, this.label});

  final String? label;
  final T? value;
  final T? groupValue;
  final Function(T)? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChanged == null || value == null) {
          return;
        }
        onChanged!(value as T);
      },
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: groupValue == value
                ? Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    color: ProjectColors.primaryVariant,

                    ),
                  )
                : null,
          ),
          if(label!=null)...{
            const SizedBox(width: 4),
            Text(label!,
            style: Theme.of(context).textTheme.titleLarge,
            )
          }
        ],
      ),
    );
  }
}
