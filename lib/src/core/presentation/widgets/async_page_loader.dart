import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../extensions/build_context_extensions.dart';

class AsyncPageLoader extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const AsyncPageLoader.loading({super.key, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 88,
            height: 88,
            child: LoadingAnimationWidget.halfTriangleDot(
              color: context.cs.primary,
              size: 65,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title ?? context.l10n.loadingTitle,
            textAlign: TextAlign.center,
            style: context.tt.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: context.cs.onSurface.withValues(alpha: .9),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle ?? context.l10n.loadingSubtitle,
            textAlign: TextAlign.center,
            style: context.tt.bodyMedium?.copyWith(
              color: context.cs.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
