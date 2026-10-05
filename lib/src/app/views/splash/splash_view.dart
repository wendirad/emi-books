// Version A: tiny private StatelessWidgets that read from context
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/constants/constants.dart';
import '../../../core/extensions/build_context_extensions.dart';
import '../../../core/presentation/widgets/widgets.dart';
import 'widgets/motto.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cs.surface,
      body: SafeArea(
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                context.isDark
                    ? Illustrations.splashScreenDark
                    : Illustrations.splashScreen,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Align(
                  alignment: Alignment.topRight,
                  child: ThemeToggleButton(),
                ),

                const Spacer(flex: 2),

                const Motto(),

                const Spacer(flex: 2),

                AppButton(
                  title: context.l10n.splashSignIn.toUpperCase(),
                  onPress: () => context.navigate(AppRoute.signIn.str),
                ),

                AppTextButton(
                  text: context.l10n.splashCreateAccount,
                  onPress: () => context.navigate(AppRoute.signUp.str),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
