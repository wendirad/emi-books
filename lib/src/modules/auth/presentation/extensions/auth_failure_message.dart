import '../../../../core/l10n/l10n.dart';
import '../../domain/failures/auth_failures.dart';

// User-facing text for each auth failure, in the user's language. The
// failure's own `message` is English for logs and tests only.

extension AuthSessionFailureMessage on AuthSessionFailure {
  String localized(AppLocalizations l10n) =>
      switch (code) {
        'session-expired' => l10n.failureSessionExpired,
        'invalid-session-cookie' => l10n.failureInvalidSessionCookie,
        'token-revoked' => l10n.failureTokenRevoked,
        _ => null,
      } ??
      commonFailureMessage(l10n, code) ??
      l10n.failureUnknown;
}

extension SignUpFailureMessage on SignUpWithEmailAndPasswordFailure {
  String localized(AppLocalizations l10n) =>
      switch (code) {
        'invalid-email' => l10n.failureInvalidEmail,
        'email-already-in-use' => l10n.failureEmailInUse,
        'weak-password' => l10n.failureWeakPassword,
        'invalid-credential' => l10n.failureInvalidCredential,
        'account-exists-with-different-credential' =>
          l10n.failureAccountExistsDifferent,
        'credential-already-in-use' => l10n.failureCredentialInUse,
        _ => null,
      } ??
      commonFailureMessage(l10n, code) ??
      l10n.failureUnknown;
}

extension SignInFailureMessage on SignInWithEmailAndPasswordFailure {
  String localized(AppLocalizations l10n) =>
      switch (code) {
        'invalid-email' => l10n.failureInvalidEmail,
        _ => null,
      } ??
      commonFailureMessage(l10n, code) ??
      l10n.failureSignInFallback;
}

extension PasswordResetFailureMessage on PasswordResetFailure {
  String localized(AppLocalizations l10n) =>
      commonFailureMessage(l10n, code) ?? l10n.failureUnknown;
}

extension PasswordResetConfirmFailureMessage on PasswordResetConfirmFailure {
  String localized(AppLocalizations l10n) =>
      switch (code) {
        'expired-action-code' => l10n.failureActionCodeExpired,
        'invalid-action-code' => l10n.failureActionCodeInvalid,
        'user-not-found' => l10n.failureActionUserNotFound,
        'weak-password' => l10n.failureNewPasswordWeak,
        _ => null,
      } ??
      commonFailureMessage(l10n, code) ??
      l10n.failureUnknown;
}

extension SignOutFailureMessage on SignOutFailure {
  String localized(AppLocalizations l10n) =>
      commonFailureMessage(l10n, code) ?? l10n.failureSignOutFallback;
}
