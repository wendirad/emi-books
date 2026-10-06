import 'package:supabase_flutter/supabase_flutter.dart';

extension AuthExceptionCodeExtensions on AuthException {
  /// The failure code for this exception, in the vocabulary of the failure
  /// tables in `domain/failures`.
  String get failureCode => switch (code) {
    'invalid_credentials' => 'invalid-credential',
    'user_already_exists' || 'email_exists' => 'email-already-in-use',
    'weak_password' => 'weak-password',
    'email_address_invalid' => 'invalid-email',
    'otp_expired' => 'expired-action-code',
    'user_not_found' => 'user-not-found',
    'over_request_rate_limit' ||
    'over_email_send_rate_limit' => 'too-many-requests',
    'user_banned' => 'user-disabled',
    'signup_disabled' => 'operation-not-allowed',
    'session_expired' || 'session_not_found' => 'session-expired',
    _ when this is AuthRetryableFetchException => 'network-request-failed',
    _ when this is AuthWeakPasswordException => 'weak-password',
    _ when this is AuthSessionMissingException => 'no-current-user',
    _ => 'unknown-error',
  };
}
