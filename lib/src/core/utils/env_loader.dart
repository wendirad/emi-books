import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment variable loader and accessor
///
/// This class provides a singleton pattern for loading and accessing
/// environment variables from .env files. It supports different environments
/// (development, test, production) and provides type-safe accessors.
class EnvLoader {
  /// Private constructor for singleton pattern
  EnvLoader._();

  /// Singleton instance
  static final EnvLoader instance = EnvLoader._();

  /// Whether the environment variables have been loaded
  bool _isLoaded = false;

  /// Get whether the environment is loaded
  bool get isLoaded => _isLoaded;

  /// Loads environment variables from .env files
  ///
  /// This method loads the base .env file and optionally a specific
  /// environment file (e.g., .env.development.local)
  ///
  /// [env] - The environment name (development, test, production, etc.)
  ///         If null, only loads the base .env file
  /// [baseFile] - The base .env file name (default: '.env')
  ///
  /// Example usage:
  /// ```dart
  /// await EnvLoader.instance.load();
  /// // or with specific environment
  /// await EnvLoader.instance.load(env: 'development');
  /// ```
  Future<void> load({String? env, String baseFile = '.env'}) async {
    try {
      // Load base .env file
      await dotenv.load(fileName: baseFile);

      // Load environment-specific file if provided
      if (env != null) {
        final envFile = '.env.$env.local';
        try {
          await dotenv.load(fileName: envFile, mergeWith: dotenv.env);
        } catch (e) {
          // Environment-specific file is optional, so we ignore errors
          // if it doesn't exist
        }
      }

      _isLoaded = true;
    } catch (e) {
      throw Exception('Failed to load environment variables: $e');
    }
  }

  /// Gets a string value from environment variables
  ///
  /// [key] - The environment variable key
  /// [defaultValue] - Optional default value if key is not found
  ///
  /// Returns the value as a String, or throws an exception if not found
  /// and no default is provided
  ///
  /// Example:
  /// ```dart
  /// final apiKey = EnvLoader.instance.getString('API_KEY');
  /// // or with default
  /// final apiUrl = EnvLoader.instance.getString('API_URL', defaultValue: 'https://api.example.com');
  /// ```
  String getString(String key, {String? defaultValue}) {
    _ensureLoaded();
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      return defaultValue ?? '';
    }
    return value;
  }

  /// Gets an integer value from environment variables
  ///
  /// [key] - The environment variable key
  /// [defaultValue] - Optional default value if key is not found
  ///
  /// Returns the value as an int, or throws an exception if not found
  /// or cannot be parsed
  ///
  /// Example:
  /// ```dart
  /// final port = EnvLoader.instance.getInt('PORT', defaultValue: 8080);
  /// ```
  int getInt(String key, {int? defaultValue}) {
    _ensureLoaded();
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      return defaultValue ?? 0;
    }
    try {
      return int.parse(value);
    } catch (e) {
      throw Exception('Failed to parse environment variable $key as int: $e');
    }
  }

  /// Gets a double value from environment variables
  ///
  /// [key] - The environment variable key
  /// [defaultValue] - Optional default value if key is not found
  ///
  /// Returns the value as a double, or throws an exception if not found
  /// or cannot be parsed
  ///
  /// Example:
  /// ```dart
  /// final version = EnvLoader.instance.getDouble('VERSION');
  /// ```
  double getDouble(String key, {double? defaultValue}) {
    _ensureLoaded();
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      return defaultValue ?? 0.0;
    }
    try {
      return double.parse(value);
    } catch (e) {
      throw Exception(
        'Failed to parse environment variable $key as double: $e',
      );
    }
  }

  /// Gets a boolean value from environment variables
  ///
  /// [key] - The environment variable key
  /// [defaultValue] - Optional default value if key is not found
  ///
  /// Returns the value as a bool. Accepts 'true', '1', 'yes', 'on' as true,
  /// and 'false', '0', 'no', 'off' as false (case-insensitive)
  ///
  /// Example:
  /// ```dart
  /// final debugMode = EnvLoader.instance.getBool('DEBUG_MODE', defaultValue: false);
  /// ```
  bool getBool(String key, {bool? defaultValue}) {
    _ensureLoaded();
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      return defaultValue ?? false;
    }
    final lowerValue = value.toLowerCase().trim();
    if (['true', '1', 'yes', 'on'].contains(lowerValue)) {
      return true;
    }
    if (['false', '0', 'no', 'off'].contains(lowerValue)) {
      return false;
    }
    throw Exception(
      'Failed to parse environment variable $key as bool. Value: $value',
    );
  }

  /// Gets an optional string value from environment variables
  ///
  /// [key] - The environment variable key
  ///
  /// Returns the value as a String? (nullable), or null if not found
  ///
  /// Example:
  /// ```dart
  /// final optionalKey = EnvLoader.instance.getOptionalString('OPTIONAL_KEY');
  /// ```
  String? getOptionalString(String key) {
    _ensureLoaded();
    return dotenv.env[key];
  }

  /// Checks if an environment variable exists
  ///
  /// [key] - The environment variable key
  ///
  /// Returns true if the key exists and has a non-empty value
  ///
  /// Example:
  /// ```dart
  /// if (EnvLoader.instance.hasKey('API_KEY')) {
  ///   // Use the key
  /// }
  /// ```
  bool hasKey(String key) {
    _ensureLoaded();
    final value = dotenv.env[key];
    return value != null && value.isNotEmpty;
  }

  /// Gets all environment variables as a map
  ///
  /// Returns a copy of all loaded environment variables
  Map<String, String> getAll() {
    _ensureLoaded();
    return Map<String, String>.from(dotenv.env);
  }

  /// Ensures that environment variables have been loaded
  void _ensureLoaded() {
    if (!_isLoaded) {
      throw Exception(
        'Environment variables have not been loaded. '
        'Call EnvLoader.instance.load() before accessing variables.',
      );
    }
  }

  /// Resets the loader (useful for testing)
  void reset() {
    dotenv.env.clear();
    _isLoaded = false;
  }
}
