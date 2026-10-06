import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/constants/constants.dart';
import '../core/l10n/l10n.dart';
import '../core/presentation/errors/errors.dart';
import '../core/theme/theme.dart';
import '../modules/auth/auth.dart';
import '../modules/profile/profile.dart';
import '../modules/settings/settings_module.dart';
import 'views/app_shell/app_shell_view.dart';
import 'views/connection_shell/connection_shell_view.dart';
import 'views/home/home_view.dart';
import 'views/splash/splash_view.dart';

Module appModule({
  required ThemeService themeService,
  required LocaleService localeService,
}) {
  return createModule(
    register: (c) {
      c
        ..addInstance<ThemeService>(themeService)
        ..addInstance<LocaleService>(localeService)
        ..addInstance<SupabaseClient>(Supabase.instance.client)
        ..route(AppRoute.splash.str, child: (_, _) => SplashView())
        ..route(AppRoute.notFound.str, child: (_, _) => _NotFound())
        ..route(
          AppRoute.app.base,
          child: (_, _) => ConnectionShellView(),
          children: (c) {
            c
              ..module(authModule)
              ..route(
                AppRoute.appShell.base,
                child: (_, _) => AppShellView(),
                guards: [authGuard],
                children: (c) {
                  c
                    ..route(AppRoute.home.base, child: (_, _) => HomeView())
                    ..module(profileModule, at: AppRoute.profile.base)
                    ..module(settingsModule, at: AppRoute.settings.base);
                },
              );
          },
        );
    },
  );
}

class _NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      const ErrorView(errorType: ErrorTypes.pageNotFound);
}
