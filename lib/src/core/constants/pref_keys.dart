/// SharedPreferences keys. The values are what existing installs already
/// store, so do not rename them without a migration.
class PrefKeys {
  const PrefKeys._();

  static const String themeMode = 'theme_mode';
  static const String locale = 'locale';
  static const String signInInfoSave = 'signInInfoSave';
  static const String rememberedEmail = 'email';

  /// Written by older builds; only ever removed.
  static const String legacyPassword = 'password';
}
