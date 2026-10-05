import '../utils/utils.dart';
import 'env_keys.dart';

/// External links, read from `.env`. A link that is not set is empty, and the
/// screens that show it hide the entry.
class AppLinks {
  const AppLinks._();

  static String get privacyPolicy => _link(EnvKeys.privacyPolicyUrl);
  static String get termsOfService => _link(EnvKeys.termsOfServiceUrl);
  static String get facebook => _link(EnvKeys.facebookUrl);
  static String get twitter => _link(EnvKeys.twitterUrl);
  static String get linkedin => _link(EnvKeys.linkedinUrl);

  static String _link(String key) => EnvLoader.instance.getString(key);
}
