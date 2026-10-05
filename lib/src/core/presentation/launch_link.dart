import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../extensions/build_context_extensions.dart';
import 'widgets/app_snack_bar.dart';

/// Opens [url] outside the app, telling the user when it cannot be opened.
Future<void> launchLink(BuildContext context, String url) async {
  final Uri? uri = Uri.tryParse(url);
  final bool opened =
      uri != null &&
      await canLaunchUrl(uri) &&
      await launchUrl(uri, mode: LaunchMode.externalApplication);

  if (!opened && context.mounted) {
    AppSnackBar.info(context, context.l10n.couldNotOpenLink(url));
  }
}
