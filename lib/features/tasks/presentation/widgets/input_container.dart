
import 'package:flutter/material.dart';

import '../../../../theme.dart';

class InputContainer extends StatelessWidget {
  const InputContainer({super.key,this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: ProjectColors.secondaryVariant,
      child: child,
    );
  }
}
