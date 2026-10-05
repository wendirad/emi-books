import 'package:flutter/material.dart';

import '../../extensions/build_context_extensions.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPress;
  final String? title;
  final Widget? child;

  /// Shows a spinner in place of the label and ignores taps.
  final bool isLoading;

  const AppButton({
    super.key,
    required this.onPress,
    this.title,
    this.child,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : () async => onPress(),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        backgroundColor: context.cs.primary,
        foregroundColor: context.cs.onPrimary,
        disabledBackgroundColor: context.cs.primary,
        disabledForegroundColor: context.cs.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: context.cs.onPrimary),
            )
          : child ?? Text(title!),
    );
  }
}
