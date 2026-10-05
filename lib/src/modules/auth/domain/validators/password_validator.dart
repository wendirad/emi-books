import 'validation_error.dart';

class PasswordValidator {
  /// Presence check only. Use for sign-in, where existing passwords may
  /// predate the current strength rules.
  ValidationError? presence(String? password) {
    if (password == null || password.isEmpty) {
      return ValidationError.passwordRequired;
    }
    return null;
  }

  ValidationError? call(String? password) {
    final ValidationError? missing = presence(password);
    if (missing != null) return missing;
    if (password == null) return null;

    if (password.length < 8) return ValidationError.passwordTooShort;
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return ValidationError.passwordNeedsUppercase;
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return ValidationError.passwordNeedsLowercase;
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return ValidationError.passwordNeedsNumber;
    }
    if (!RegExp(r'[!@#\$&*~]').hasMatch(password)) {
      return ValidationError.passwordNeedsSpecial;
    }
    return null;
  }
}
