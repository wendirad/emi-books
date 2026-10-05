import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/constants/constants.dart';
import '../../../core/extensions/build_context_extensions.dart';
import '../../../core/presentation/widgets/widgets.dart';
import '../../../modules/auth/auth.dart';
import 'widgets/app_navigation_bar.dart';

class AppShellView extends StatefulWidget {
  const AppShellView({super.key});

  @override
  State<AppShellView> createState() => _AppShellViewState();
}

class _AppShellViewState extends State<AppShellView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthSessionBloc(
        observeAuthSession: inject<ObserveAuthSessionUseCase>(),
      )..add(AuthSessionUserSubscriptionRequested()),
      child: BlocListener<AuthSessionBloc, AuthSessionState>(
        listenWhen: (p, c) => p != c,
        listener: _handleAuthState,
        child: _RouterOutlet(),
      ),
    );
  }

  void _handleAuthState(BuildContext context, AuthSessionState state) {
    if (!state.isAuthenticated) {
      if (state.failure case final failure?) {
        AppSnackBar.error(context, failure.message);
      }

      context.navigate(AppRoute.signIn.str);
    }
  }
}

class _RouterOutlet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: context.cs.surfaceDim,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: RouterOutlet(),
      ),
      bottomNavigationBar: AppNavigationBar(),
    );
  }
}
