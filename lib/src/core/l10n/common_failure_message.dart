import 'generated/app_localizations.dart';

/// The message for a code every feature can meet (see `failure_messages.dart`
/// in `core/failures`), or null when [code] is not one of them.
String? commonFailureMessage(AppLocalizations l10n, String? code) =>
    switch (code) {
      'network-request-failed' => l10n.failureNetwork,
      'internal-error' => l10n.failureInternal,
      'user-disabled' => l10n.failureUserDisabled,
      'operation-not-allowed' => l10n.failureOperationNotAllowed,
      'too-many-requests' => l10n.failureTooManyRequests,
      'no-current-user' => l10n.failureNoCurrentUser,
      'requires-recent-login' => l10n.failureRequiresRecentLogin,
      _ => null,
    };
