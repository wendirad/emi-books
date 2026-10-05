import 'package:flutter/material.dart';

import '../../extensions/build_context_extensions.dart';

/// Floating snack bars with one look across the app.
class AppSnackBar {
  const AppSnackBar._();

  static void success(BuildContext context, String message) =>
      _show(
        context,
        message,
        context.appColors.success,
        context.appColors.onSuccess,
      );

  static void error(BuildContext context, String message) =>
      _show(context, message, context.cs.error, context.cs.onError);

  static void info(BuildContext context, String message) =>
      _show(context, message, null, null);

  static void _show(
    BuildContext context,
    String message,
    Color? background,
    Color? foreground,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: foreground)),
        backgroundColor: background,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
