import 'package:flutter/material.dart';

import '../../../../../../core/presentation/widgets/widgets.dart';

/// "Prompt  Action" row shown under an auth form, e.g. "Already have an
/// account? Sign In".
class AuthFooter extends StatelessWidget {
  final String prompt;
  final String actionText;
  final VoidCallback onAction;

  const AuthFooter({
    super.key,
    required this.prompt,
    required this.actionText,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(prompt),
        AppTextButton(text: actionText, onPress: onAction),
      ],
    );
  }
}
