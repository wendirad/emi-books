import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../../core/extensions/build_context_extensions.dart';

/// "Version x.y.z" read from the installed package.
class AppVersionText extends StatefulWidget {
  const AppVersionText({super.key});

  @override
  State<AppVersionText> createState() => _AppVersionTextState();
}

class _AppVersionTextState extends State<AppVersionText> {
  late final Future<PackageInfo> _info = PackageInfo.fromPlatform();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: _info,
      builder: (context, snapshot) {
        final String? version = snapshot.data?.version;

        return Text(
          version == null ? '' : context.l10n.appVersion(version),
          style: context.tt.bodySmall?.copyWith(
            color: context.cs.onSurface.withValues(alpha: 0.5),
          ),
        );
      },
    );
  }
}
