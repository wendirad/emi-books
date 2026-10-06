import '../../../../core/l10n/l10n.dart';
import '../../domain/validators/validation_error.dart';

extension ValidationErrorMessage on ValidationError {
  String message(AppLocalizations l10n) => switch (this) {
    ValidationError.emailInvalid => l10n.validationEmailInvalid,
    ValidationError.passwordRequired => l10n.validationPasswordRequired,
    ValidationError.passwordTooShort => l10n.validationPasswordTooShort,
    ValidationError.passwordNeedsUppercase => l10n.validationPasswordUppercase,
    ValidationError.passwordNeedsLowercase => l10n.validationPasswordLowercase,
    ValidationError.passwordNeedsNumber => l10n.validationPasswordNumber,
    ValidationError.passwordNeedsSpecial => l10n.validationPasswordSpecial,
    ValidationError.confirmationRequired => l10n.validationConfirmRequired,
    ValidationError.passwordsDoNotMatch => l10n.validationPasswordsMismatch,
    ValidationError.valueRequired => l10n.validationValueRequired,
    ValidationError.codeInvalid => l10n.validationCodeInvalid,
  };
}
