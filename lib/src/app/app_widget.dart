import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/l10n/l10n.dart';
import '../core/theme/theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeService themeService = inject<ThemeService>();
    final LocaleService localeService = inject<LocaleService>();

    return ListenableBuilder(
      listenable: Listenable.merge([themeService, localeService]),
      builder: (context, _) {
        return MaterialApp.router(
          locale: localeService.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          title: 'Emi Books',
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: themeService.mode,
          routerConfig: ModularApp.routerConfigOf(context),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
