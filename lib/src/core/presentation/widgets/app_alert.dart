import 'package:flutter/material.dart';

import '../../extensions/build_context_extensions.dart';

enum AlertVariant { primary, success, info, warning, danger }

class AppAlert extends StatelessWidget {
  const AppAlert({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.variant = AlertVariant.primary,
  });

  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final AlertVariant variant;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final _Palette p = switch (variant) {
      AlertVariant.primary => _Palette(cs.primary, cs.onPrimary),
      AlertVariant.success => _Palette(cs.secondary, cs.onSecondary),
      AlertVariant.info => _Palette(cs.tertiary, cs.onTertiary),
      AlertVariant.warning => _Palette(cs.errorContainer, cs.onErrorContainer),
      AlertVariant.danger => _Palette(cs.error, cs.onError),
    };

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: p.bg.withValues(alpha: .12),
        border: Border.all(color: p.bg.withValues(alpha: .35)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // CENTER VERTICALLY
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: p.bg.withValues(alpha: .18),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: p.bg),
            ),
          if (icon != null) const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:
                  MainAxisAlignment.center, // keep column centered
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: p.bg),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(color: p.bg),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Palette {
  final Color bg;
  final Color fg;
  const _Palette(this.bg, this.fg);
}
