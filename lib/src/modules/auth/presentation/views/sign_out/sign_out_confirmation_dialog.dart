import 'package:flutter/material.dart';

import '../../../../../core/extensions/build_context_extensions.dart';

class SignOutConfirmationDialog extends StatelessWidget {
  const SignOutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon Container
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.cs.errorContainer,
              ),
              child: Icon(
                Icons.logout_rounded,
                color: context.cs.error,
                size: 32,
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              context.l10n.authSignOut,
              style: context.tt.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.cs.onSurface,
              ),
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              context.l10n.signOutConfirmMessage,
              textAlign: TextAlign.center,
              style: context.tt.bodyMedium?.copyWith(
                color: context.cs.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(
                        color: context.cs.outline.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      context.l10n.actionCancel,
                      style: context.tt.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.cs.onSurface,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.cs.error,
                      foregroundColor: context.cs.onError,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      context.l10n.authSignOut,
                      style: context.tt.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.cs.onError,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
