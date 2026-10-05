import '../utils/utils.dart';
import 'env_keys.dart';

class EndPoints {
  static final String avatarsPublicProvider = EnvLoader.instance.getString(
    EnvKeys.avatarsPublicProvider,
  );
}
