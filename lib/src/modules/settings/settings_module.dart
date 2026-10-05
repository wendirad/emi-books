import 'package:flutter_modular/flutter_modular.dart';

import '../../core/constants/constants.dart';
import 'presentation/views/views.dart';

/// Settings routes. Mount with `c.module(settingsModule, at: AppRoute.settings.base)`.
final Module settingsModule = createModule(
  register: (c) {
    c
      ..route(AppRoute.root.base, child: (_, _) => SettingsView())
      ..route(AppRoute.about.base, child: (_, _) => AboutView());
  },
);
