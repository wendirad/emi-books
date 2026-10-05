import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../../../domain/failures/auth_failures.dart';
import '../../../domain/use_cases/use_cases.dart';
import '../../cubits/confirm_password_reset/confirm_password_reset_cubit.dart';
import '../../extensions/auth_failure_message.dart';
import '../widgets/widgets.dart';

class ConfirmPasswordResetView extends StatefulWidget {
  const ConfirmPasswordResetView({super.key});

  @override
  State<ConfirmPasswordResetView> createState() =>
      _ConfirmPasswordResetViewState();
}

class _ConfirmPasswordResetViewState extends State<ConfirmPasswordResetView> {
  final _confirmPasswordResetViewFormKey = GlobalKey<FormState>();

  String? verificationCode;
  bool _verifying = true;

  @override
  void initState() {
    super.initState();
    _checkVerificationCode();
  }

  @override
  Widget build(BuildContext context) {
    if (_verifying) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return BlocProvider(
      create: (_) => ConfirmPasswordResetCubit(
        confirmPasswordReset: inject<ConfirmPasswordResetUseCase>(),
      ),
      child: BlocListener<ConfirmPasswordResetCubit, ConfirmPasswordResetState>(
        listenWhen: (p, c) => p != c,
        listener: (context, state) {
          if (state.isSuccess) {
            AppSnackBar.success(context, context.l10n.confirmResetSuccess);
            context.navigate(AppRoute.signIn.str);
          }
        },
        child: AuthScaffold(
          title: context.l10n.fieldConfirmPassword,
          subtitle: context.l10n.confirmResetSubtitle,
          form: _ConfirmPasswordResetViewForm(
            formKey: _confirmPasswordResetViewFormKey,
            code: verificationCode,
          ),
          footer: AuthFooter(
            prompt: context.l10n.passwordResetRememberPrompt,
            actionText: context.l10n.authSignIn,
            onAction: () => context.pushNamed(AppRoute.signIn.str),
          ),
        ),
      ),
    );
  }

  Future<void> _checkVerificationCode() async {
    final Object? data = context.routeState(listen: false).arguments;
    final String oobCode = switch (data) {
      Map() => data['oobCode'] as String? ?? '',
      _ => '',
    };

    final verification = await inject<VerifyPasswordResetCodeUseCase>()(
      param: VerifyPasswordResetCodeParam(code: oobCode),
    );
    if (!mounted) return;

    final PasswordResetConfirmFailure? failure = verification.fold(
      (l) => l,
      (_) => null,
    );
    if (failure != null) {
      context.navigate(AppRoute.resetPassword.str, arguments: failure);
      return;
    }

    setState(() {
      verificationCode = oobCode;
      _verifying = false;
    });
  }
}

class _ConfirmPasswordResetViewForm extends StatefulWidget {
  final String? code;
  final GlobalKey<FormState> formKey;

  const _ConfirmPasswordResetViewForm({
    required this.formKey,
    required this.code,
  });

  @override
  State<_ConfirmPasswordResetViewForm> createState() =>
      _ConfirmPasswordResetViewFormState();
}

class _ConfirmPasswordResetViewFormState
    extends State<_ConfirmPasswordResetViewForm> {
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
          key: widget.formKey,
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
                  if (widget.formKey.currentState!.validate()) {
                    ReadContext(
                      context,
                    ).read<ConfirmPasswordResetCubit>().submit(
                      code: widget.code ?? '',
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
