import 'package:flutter/material.dart';

import '../../../core/extensions/build_context_extensions.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(context.l10n.navHome));
  }
}
