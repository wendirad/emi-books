import 'validation_error.dart';

class CodeValidator {
  static final RegExp _codeRegex = RegExp(r'^\d{6}$');

  ValidationError? call(String? code) {
    if (code == null || !_codeRegex.hasMatch(code.trim())) {
      return ValidationError.codeInvalid;
    }

    return null;
  }
}
