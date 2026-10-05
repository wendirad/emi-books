import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../../../domain/use_cases/use_cases.dart';
import '../../cubits/remembered_email/remembered_email_cubit.dart';
import '../../cubits/sign_in/sign_in_cubit.dart';
import '../../extensions/auth_failure_message.dart';
import '../widgets/widgets.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _signInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SignInCubit(
            signIn: inject<SignInWithEmailAndPasswordUseCase>(),
          ),
        ),
        BlocProvider(
          create: (_) => RememberedEmailCubit(
            getRememberedEmail: inject<GetRememberedEmailUseCase>(),
          )..load(),
        ),
      ],
      child: BlocListener<SignInCubit, SignInState>(
        listenWhen: (p, c) => p != c,
        listener: (context, state) async {
          if (state.isSuccess) {
            AppSnackBar.success(context, context.l10n.signInSuccess);

            context.navigate(AppRoute.home.str);
          }
        },
        child: AuthScaffold(
          title: context.l10n.signInTitle,
          subtitle: context.l10n.signInSubtitle,
          form: _SignInForm(formKey: _signInFormKey),
          footer: AuthFooter(
            prompt: context.l10n.signInNoAccountPrompt,
            actionText: context.l10n.authSignUp,
            onAction: () => context.pushNamed(AppRoute.signUp.str),
          ),
        ),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const _SignInForm({required this.formKey});

  @override
  State<_SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _saveInfo = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _applyRememberedEmail(String? email) {
    if (email == null || email.isEmpty) return;

    _emailController.text = email;
    setState(() => _saveInfo = true);
  }

  @override
  Widget build(BuildContext context) {
    final SignInState state = WatchContext(context).watch<SignInCubit>().state;

    return BlocListener<RememberedEmailCubit, RememberedEmailState>(
      listenWhen: (p, c) => p != c,
      listener: (context, remembered) => _applyRememberedEmail(remembered.data),
      child: Column(
        spacing: 8,
        children: [
          if (state.failure case final failure?) ...[
            AppAlert(
              title: context.l10n.signInFailedTitle,
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

                PasswordField(
                  controller: _passwordController,
                  enforceStrength: false,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CheckboxField(
                      isChecked: _saveInfo,
                      onToggle: () => setState(() => _saveInfo = !_saveInfo),
                      suffix: Text(context.l10n.signInRememberEmail),
                    ),
                    AppTextButton(
                      text: context.l10n.signInForgotPassword,
                      onPress: () async {
                        await context.pushNamed(AppRoute.resetPassword.str);
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                AppButton(
                  onPress: () {
                    if (widget.formKey.currentState!.validate()) {
                      ReadContext(context).read<SignInCubit>().submit(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                        saveInfo: _saveInfo,
                      );
                    }
                  },
                  isLoading: state.isInProgress,
                  title: context.l10n.authSignIn,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
