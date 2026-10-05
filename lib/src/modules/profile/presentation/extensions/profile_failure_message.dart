import '../../../../core/l10n/l10n.dart';
import '../../domain/failures/profile_failures.dart';

extension ProfileUpdateFailureMessage on ProfileUpdateFailure {
  /// User-facing text in the user's language. The failure's own `message` is
  /// English for logs and tests only.
  String localized(AppLocalizations l10n) =>
      commonFailureMessage(l10n, code) ?? l10n.failureProfileFallback;
}
