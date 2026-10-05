import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/extensions/build_context_extensions.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = _indexForPath(context.routeState().uri.path) ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: context.cs.primaryContainer.withAlpha(150),
        boxShadow: [
          BoxShadow(blurRadius: 20, color: context.cs.shadow.withAlpha(25)),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: context.cs.outlineVariant,
            hoverColor: context.cs.outlineVariant,
            gap: 8,
            activeColor: context.cs.inversePrimary,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: (context.isDark
                ? context.cs.inverseSurface
                : context.cs.surface)
                .withAlpha(200),
            color: context.cs.inversePrimary,
            tabs: [
              GButton(icon: Icons.home_outlined, text: context.l10n.navHome),
              GButton(
                icon: Icons.settings_outlined,
                text: context.l10n.navSettings,
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: (index) => _navigate(context, selectedIndex, index),
          ),
        ),
      ),
    );
  }

  void _navigate(BuildContext context, int selectedIndex, int index) {
    if (index == selectedIndex) return;

    context.navigate(switch (index) {
      0 => AppRoute.home.str,
      1 => AppRoute.settings.str,
      _ => AppRoute.notFound.str,
    });
  }

  int? _indexForPath(String path) {
    final current = AppRoute.fromPath(path);
    if (current.isOrIsChildOf(AppRoute.home)) return 0;
    if (current.isOrIsChildOf(AppRoute.settings) ||
        current.isOrIsChildOf(AppRoute.profile)) {
      return 1;
    }
    return null;
  }
}
