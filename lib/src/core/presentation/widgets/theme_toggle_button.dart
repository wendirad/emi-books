import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../extensions/build_context_extensions.dart';
import '../../theme/theme.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return IconButton(
      tooltip: context.l10n.toggleThemeTooltip,
      icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
      color: context.appColors.onOverlay,
      style: IconButton.styleFrom(
        backgroundColor: context.appColors.overlay,
      ),
      onPressed: () =>
          inject<ThemeService>().toggle(context.brightness),
    );
  }
}
