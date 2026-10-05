import 'package:flutter/material.dart';

import '../../../../../../core/extensions/build_context_extensions.dart';

class CheckboxField extends StatelessWidget {
  final VoidCallback? onToggle;
  final bool isChecked;
  final Widget? suffix;

  const CheckboxField({
    super.key,
    this.onToggle,
    this.isChecked = false,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Row(
        spacing: 4,
        children: [
          Icon(
            isChecked ? Icons.check_circle_outline : Icons.circle_outlined,
            color: context.cs.outline,
            size: 20,
          ),
          ?suffix,
        ],
      ),
    );
  }
}
