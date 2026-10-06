import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../../../domain/use_cases/use_cases.dart';
import '../../cubits/password_reset/password_reset_cubit.dart';
import '../../extensions/auth_failure_message.dart';
import '../widgets/widgets.dart';

class PasswordResetView extends StatefulWidget {
  const PasswordResetView({super.key});

  @override
  State<PasswordResetView> createState() => _PasswordResetViewState();
}

class _PasswordResetViewState extends State<PasswordResetView> {
  final _passwordResetViewFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasswordResetCubit(
        sendPasswordResetEmail: inject<SendPasswordResetEmailUseCase>(),
      ),

      child: AuthScaffold(
        title: context.l10n.passwordResetTitle,
        subtitle: context.l10n.passwordResetSubtitle,
        form: _PasswordResetViewForm(formKey: _passwordResetViewFormKey),
        footer: AuthFooter(
          prompt: context.l10n.passwordResetRememberPrompt,
          actionText: context.l10n.authSignIn,
          onAction: () => context.pushNamed(AppRoute.signIn.str),
        ),
      ),
    );
  }
}

class _PasswordResetViewForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const _PasswordResetViewForm({required this.formKey});

  @override
  State<_PasswordResetViewForm> createState() => _PasswordResetViewFormState();
}

class _PasswordResetViewFormState extends State<_PasswordResetViewForm> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PasswordResetState state = WatchContext(
      context,
    ).watch<PasswordResetCubit>().state;

    return BlocListener<PasswordResetCubit, PasswordResetState>(
      listenWhen: (p, c) => p != c,
      listener: (context, state) {
        if (state.isSuccess) {
          AppSnackBar.success(context, context.l10n.passwordResetEmailSent);
          context.navigate(
            AppRoute.confirmPasswordReset.str,
            arguments: {
              'mode': 'resetPassword',
              'email': _emailController.text.trim(),
            },
          );
        }
      },
      child: Column(
        spacing: 8,
        children: [
          if (state.failure case final failure?) ...[
            AppAlert(
              title: context.l10n.passwordResetFailedTitle,
              value: failure.localized(context.l10n),
              variant: AlertVariant.danger,
              icon: Icons.report_gmailerrorred_outlined,
            ),
          ],

          Form(
            key: widget.formKey,
            child: Column(
              spacing: 16,
              children: [
                EmailField(controller: _emailController),

                const SizedBox(height: 16),

                AppButton(
                  onPress: () {
                    if (widget.formKey.currentState!.validate()) {
                      ReadContext(context).read<PasswordResetCubit>().submit(
                        email: _emailController.text.trim(),
                      );
                    }
                  },
                  isLoading: state.isInProgress,
                  title: context.l10n.passwordResetSendButton,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
