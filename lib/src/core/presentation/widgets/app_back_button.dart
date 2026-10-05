import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../extensions/build_context_extensions.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (!context.canPop()) return const SizedBox.shrink();

    return IconButton(
      tooltip: context.l10n.actionBack,
      icon: const Icon(Icons.arrow_back),
      color: context.appColors.onOverlay,
      style: IconButton.styleFrom(backgroundColor: context.appColors.overlay),
      onPressed: context.maybePop,
    );
  }
}
