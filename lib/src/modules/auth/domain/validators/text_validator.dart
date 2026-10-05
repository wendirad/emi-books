import 'validation_error.dart';

class TextValidator {
  ValidationError? call(String? text) {
    if (text == null || text.trim().isEmpty) {
      return ValidationError.valueRequired;
    }
    return null;
  }
}
