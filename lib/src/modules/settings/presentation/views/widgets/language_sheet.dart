import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/l10n/l10n.dart';

/// The language the app is showing right now, as a label for the settings tile.
String currentLanguageLabel(BuildContext context, Locale? selected) =>
    selected == null
    ? context.l10n.languageSystemDefault
    : lookupAppLocalizations(selected).languageName;

/// Lets the user pick the app language, or follow the device.
Future<void> showLanguageSheet(BuildContext context) {
  final LocaleService service = inject<LocaleService>();

  return showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) => SafeArea(
      child: RadioGroup<Locale?>(
        groupValue: service.locale,
        onChanged: (locale) {
          service.select(locale);
          Navigator.pop(sheetContext);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<Locale?>(
              value: null,
              title: Text(sheetContext.l10n.languageSystemDefault),
            ),
            for (final Locale locale in AppLocalizations.supportedLocales)
              RadioListTile<Locale?>(
                value: locale,
                title: Text(lookupAppLocalizations(locale).languageName),
              ),
          ],
        ),
      ),
    ),
  );
}
