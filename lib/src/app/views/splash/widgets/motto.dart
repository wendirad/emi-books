import 'package:flutter/material.dart';

import '../../../../core/extensions/build_context_extensions.dart';

class Motto extends StatelessWidget {
  const Motto({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final emphasis = context.isDark
        ? context.cs.primary.withValues(alpha: 0.6)
        : context.cs.primary;

    final baseStyle = (context.tt.headlineLarge ?? const TextStyle()).copyWith(
      color: context.cs.onSurface,
      height: 1.1,
      fontWeight: FontWeight.w700,
      fontSize: 24,
    );

    return RichText(
      textAlign: TextAlign.center,
      maxLines: 2,
      text: TextSpan(
        style: baseStyle,
        children: [
          TextSpan(text: l10n.mottoFirstLead, style: baseStyle.copyWith(fontSize: 25)),
          TextSpan(
            text: l10n.mottoFirstEmphasis,
            style: baseStyle.copyWith(color: emphasis, fontSize: 35),
          ),
          TextSpan(
            text: '${l10n.mottoSentenceEnd}\n${l10n.mottoSecondLead}',
            style: baseStyle.copyWith(fontSize: 25),
          ),
          TextSpan(
            text: l10n.mottoSecondEmphasis,
            style: baseStyle.copyWith(color: emphasis, fontSize: 35),
          ),
          TextSpan(text: l10n.mottoSentenceEnd),
        ],
      ),
    );
  }
}
