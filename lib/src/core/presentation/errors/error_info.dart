import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../extensions/build_context_extensions.dart';
import '../widgets/widgets.dart';

class ErrorInfo extends StatelessWidget {
  const ErrorInfo({
    super.key,
    required this.title,
    required this.description,
    required this.onPress,
    this.button,
    this.buttonText,
  });

  final String title;
  final String description;
  final Widget? button;
  final String? buttonText;
  final AsyncCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: context.cs.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              textAlign: TextAlign.center,
              style: context.tt.bodyMedium,
            ),
            const SizedBox(height: 16 * 2.5),
            button ??
                AppButton(
                  onPress: () async => await onPress(),
                  title: buttonText ?? context.l10n.actionRetry.toUpperCase(),
                ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
