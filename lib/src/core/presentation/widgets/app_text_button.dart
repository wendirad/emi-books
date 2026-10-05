import 'package:flutter/material.dart';

import '../../extensions/build_context_extensions.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;

  const AppTextButton({super.key, required this.text, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      style: context.theme.textButtonTheme.style?.copyWith(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: context.isDark ? context.cs.onSurface : context.cs.primary,
          fontSize: 15,
        ),
      ),
    );
  }
}
