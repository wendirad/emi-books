import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../constants/constants.dart';
import '../../extensions/build_context_extensions.dart';
import '../../l10n/l10n.dart';
import '../widgets/illustration.dart';
import 'error_info.dart';

class ErrorView extends StatelessWidget {
  final ErrorTypes errorType;
  final String? title;
  final String? description;
  final Widget? button;
  final String? buttonText;
  final AsyncCallback? onButtonPress;

  const ErrorView({
    super.key,
    this.errorType = ErrorTypes.unknownError,
    this.title,
    this.description,
    this.buttonText,
    this.onButtonPress,
    this.button,
  });

  @override
  Widget build(BuildContext context) {
    final _ErrorContent content = _ErrorContent.of(errorType, context.l10n);

    return Container(
      color: context.cs.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(flex: 2),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Illustration(
                    content.illustration,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),

              const Spacer(flex: 2),

              ErrorInfo(
                title: title ?? content.title,
                description: description ?? content.description,
                button: button,
                buttonText: buttonText ?? content.buttonText,
                onPress: onButtonPress ?? () => content.onPress(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Default illustration, copy and retry action for each [ErrorTypes] value.
class _ErrorContent {
  final String illustration;
  final String title;
  final String description;
  final String buttonText;
  final Future<void> Function(BuildContext context) onPress;

  const _ErrorContent({
    required this.illustration,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPress,
  });

  static _ErrorContent of(ErrorTypes type, AppLocalizations l10n) => switch (type) {
    ErrorTypes.pageNotFound => _ErrorContent(
      illustration: Illustrations.pageNotFound,
      title: l10n.errorPageNotFoundTitle,
      description: l10n.errorPageNotFoundMessage,
      buttonText: l10n.actionBack,
      onPress: (context) async {
        if (!context.maybePop()) {
          await context.replace(AppRoute.home.str);
        }
      },
    ),
    ErrorTypes.noConnection => _ErrorContent(
      illustration: Illustrations.noConnection,
      title: l10n.errorNoConnectionTitle,
      description: l10n.errorNoConnectionMessage,
      buttonText: l10n.actionTryAgain,
      onPress: (context) async =>
          context.navigate(context.routeState(listen: false).uri.toString()),
    ),
    ErrorTypes.underMaintenance => _ErrorContent(
      illustration: Illustrations.underMaintenance,
      title: l10n.errorMaintenanceTitle,
      description: l10n.errorMaintenanceMessage,
      buttonText: l10n.actionTryAgain,
      onPress: (_) async {},
    ),
    ErrorTypes.noData => _ErrorContent(
      illustration: Illustrations.noData,
      title: l10n.errorNoDataTitle,
      description: l10n.errorNoDataMessage,
      buttonText: l10n.actionRetry,
      onPress: (context) async {
        final String path = context.routeState(listen: false).uri.toString();
        if (context.canPop()) {
          await context.popAndPushNamed(path);
        } else {
          await context.pushNamed(path);
        }
      },
    ),
    ErrorTypes.unknownError => _ErrorContent(
      illustration: Illustrations.unknownError,
      title: l10n.errorUnknownTitle,
      description: l10n.errorUnknownMessage,
      buttonText: l10n.actionTryAgain,
      onPress: (context) async => await context.pushNamed(
        context.routeState(listen: false).uri.toString(),
      ),
    ),
  };
}
