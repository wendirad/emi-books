import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../../cubits/sign_out/sign_out_cubit.dart';
import '../../extensions/auth_failure_message.dart';
import 'sign_out_confirmation_dialog.dart';

class SignOutCard extends StatelessWidget {
  const SignOutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignOutCubit, SignOutState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state.isSuccess) {
          AppSnackBar.success(context, context.l10n.signOutSuccess);
          context.navigate(AppRoute.signIn.str);
        } else if (state.failure case final failure?) {
          AppSnackBar.error(context, failure.localized(context.l10n));
        }
      },
      child: Card(
        child: _SignOutTile(
          icon: Icons.logout,
          title: context.l10n.authSignOut,
          subtitle: context.l10n.signOutSubtitle,
          trailing: BlocBuilder<SignOutCubit, SignOutState>(
            builder: (context, state) {
              if (state.isInProgress) {
                return SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(context.cs.error),
                  ),
                );
              }
              return const Icon(Icons.chevron_right);
            },
          ),
          onTap: () => _handleSignOut(context),
        ),
      ),
    );
  }

  Future<void> _handleSignOut(BuildContext context) async {
    final shouldSignOut = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => const SignOutConfirmationDialog(),
    );

    if (shouldSignOut == true && context.mounted) {
      await ReadContext(context).read<SignOutCubit>().submit();
    }
  }
}

class _SignOutTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SignOutTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.cs.errorContainer.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: context.cs.error, size: 20),
      ),
      title: Text(
        title,
        style: context.tt.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: context.cs.error,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: context.tt.bodySmall?.copyWith(
                color: context.cs.onSurface.withValues(alpha: 0.6),
              ),
            )
          : null,
      trailing: trailing,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
