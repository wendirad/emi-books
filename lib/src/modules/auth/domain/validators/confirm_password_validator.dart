import 'validation_error.dart';

class ConfirmPasswordValidator {
  ValidationError? call(String? confirmPassword, String? password) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return ValidationError.confirmationRequired;
    }
    if (password == null || password.isEmpty) {
      return ValidationError.passwordRequired;
    }
    if (confirmPassword != password) {
      return ValidationError.passwordsDoNotMatch;
    }
    return null;
  }
}
