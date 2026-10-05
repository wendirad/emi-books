import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/pref_keys.dart';
import 'generated/app_localizations.dart';

class LocaleService extends ChangeNotifier {
  Locale? _locale;

  /// The language the user picked, or null to follow the device.
  Locale? get locale => _locale;

  /// Reads the saved language. Call once before `runApp` so the first frame
  /// already uses it.
  Future<void> load() async {
    final pref = await SharedPreferences.getInstance();
    final String? code = pref.getString(PrefKeys.locale);
    _locale = AppLocalizations.supportedLocales
        .where((l) => l.languageCode == code)
        .firstOrNull;
    notifyListeners();
  }

  /// Switches to [locale], or back to the device language when it is null.
  Future<void> select(Locale? locale) async {
    _locale = locale;
    final pref = await SharedPreferences.getInstance();
    if (locale == null) {
      await pref.remove(PrefKeys.locale);
    } else {
      await pref.setString(PrefKeys.locale, locale.languageCode);
    }
    notifyListeners();
  }
}
