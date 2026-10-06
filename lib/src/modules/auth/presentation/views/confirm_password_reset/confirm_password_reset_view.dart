import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../../../domain/use_cases/use_cases.dart';
import '../../cubits/confirm_password_reset/confirm_password_reset_cubit.dart';
import '../../cubits/verify_password_reset_code/verify_password_reset_code_cubit.dart';
import '../../extensions/auth_failure_message.dart';
import '../widgets/widgets.dart';

class ConfirmPasswordResetView extends StatefulWidget {
  const ConfirmPasswordResetView({super.key});

  @override
  State<ConfirmPasswordResetView> createState() =>
      _ConfirmPasswordResetViewState();
}

class _ConfirmPasswordResetViewState extends State<ConfirmPasswordResetView> {
  bool _codeVerified = false;

  @override
  Widget build(BuildContext context) {
    final Object? data = context.routeState(listen: false).arguments;
    final String email = switch (data) {
      Map() => data['email'] as String? ?? '',
      _ => '',
    };

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => VerifyPasswordResetCodeCubit(
            verifyPasswordResetCode: inject<VerifyPasswordResetCodeUseCase>(),
          ),
        ),
        BlocProvider(
          create: (_) => ConfirmPasswordResetCubit(
            confirmPasswordReset: inject<ConfirmPasswordResetUseCase>(),
          ),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<
            VerifyPasswordResetCodeCubit,
            VerifyPasswordResetCodeState
          >(
            listenWhen: (p, c) => p != c,
            listener: (context, state) {
              if (state.isSuccess) setState(() => _codeVerified = true);
            },
          ),
          BlocListener<ConfirmPasswordResetCubit, ConfirmPasswordResetState>(
            listenWhen: (p, c) => p != c,
            listener: (context, state) {
              if (state.isSuccess) {
                AppSnackBar.success(context, context.l10n.confirmResetSuccess);
                context.navigate(AppRoute.signIn.str);
              }
            },
          ),
        ],
        child: AuthScaffold(
          title: context.l10n.fieldConfirmPassword,
          subtitle: _codeVerified
              ? context.l10n.confirmResetSubtitle
              : context.l10n.confirmResetCodeSubtitle,
          form: _codeVerified
              ? const _NewPasswordForm()
              : _CodeForm(email: email),
          footer: AuthFooter(
            prompt: context.l10n.passwordResetRememberPrompt,
            actionText: context.l10n.authSignIn,
            onAction: () => context.pushNamed(AppRoute.signIn.str),
          ),
        ),
      ),
    );
  }
}

class _CodeForm extends StatefulWidget {
  final String email;

  const _CodeForm({required this.email});

  @override
  State<_CodeForm> createState() => _CodeFormState();
}

class _CodeFormState extends State<_CodeForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final VerifyPasswordResetCodeState state = WatchContext(
      context,
    ).watch<VerifyPasswordResetCodeCubit>().state;

    return Column(
      spacing: 8,
      children: [
        if (state.failure case final failure?) ...[
          AppAlert(
            title: context.l10n.passwordResetConfirmationFailedTitle,
            value: failure.localized(context.l10n),
            variant: AlertVariant.danger,
            icon: Icons.report_gmailerrorred_outlined,
          ),
        ],

        Form(
          key: _formKey,
          child: Column(
            spacing: 16,
            children: [
              CodeField(controller: _codeController),

              const SizedBox(height: 16),

              AppButton(
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    ReadContext(
                      context,
                    ).read<VerifyPasswordResetCodeCubit>().submit(
                      email: widget.email,
                      code: _codeController.text.trim(),
                    );
                  }
                },
                isLoading: state.isInProgress,
                title: context.l10n.confirmResetVerifyButton,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NewPasswordForm extends StatefulWidget {
  const _NewPasswordForm();

  @override
  State<_NewPasswordForm> createState() => _NewPasswordFormState();
}

class _NewPasswordFormState extends State<_NewPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ConfirmPasswordResetState state = WatchContext(
      context,
    ).watch<ConfirmPasswordResetCubit>().state;

    return Column(
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
          key: _formKey,
          child: Column(
            spacing: 16,
            children: [
              PasswordField(controller: _newPasswordController),

              PasswordField(
                controller: _confirmNewPasswordController,
                confirms: _newPasswordController,
                hintText: context.l10n.fieldConfirmPassword,
              ),

              const SizedBox(height: 16),

              AppButton(
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    ReadContext(
                      context,
                    ).read<ConfirmPasswordResetCubit>().submit(
                      newPassword: _newPasswordController.text.trim(),
                    );
                  }
                },
                isLoading: state.isInProgress,
                title: context.l10n.confirmResetButton,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
