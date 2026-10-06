/// Keys read from `.env` through EnvLoader. Document every new key in the
/// README so a generated project knows what to set.
class EnvKeys {
  const EnvKeys._();

  // Supabase (self-hosted). The anon key is public; never put the service
  // role key here.
  static const String supabaseUrl = 'supabaseUrl';
  static const String supabaseAnonKey = 'supabaseAnonKey';

  // Firebase App Check / emulators (debug builds only)
  static const String androidDebugToken = 'androidDebugToken';
  static const String appleDebugToken = 'appleDebugToken';
  static const String useEmulators = 'useEmulators';
  static const String emulatorDebugHost = 'emulatorDebugHost';
  static const String authEmulatorPort = 'authEmulatorPort';
  static const String firestoreEmulatorPort = 'firestoreEmulatorPort';
  static const String storageEmulatorPort = 'storageEmulatorPort';

  // Password reset links
  static const String passwordResetContinueUrl = 'passwordResetContinueURL';
  static const String androidPackageName = 'androidPackageName';
  static const String iosBundleId = 'iOSBundleId';

  // Content
  static const String avatarsPublicProvider = 'avatarsPublicProvider';
  static const String privacyPolicyUrl = 'privacyPolicyUrl';
  static const String termsOfServiceUrl = 'termsOfServiceUrl';
  static const String facebookUrl = 'facebookUrl';
  static const String twitterUrl = 'twitterUrl';
  static const String linkedinUrl = 'linkedinUrl';
}
