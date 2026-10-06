// The package import carries the generated project name, which can sort
// differently from here.
// ignore_for_file: directives_ordering

import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:emi_books/src/modules/auth/data/extensions/auth_exception_extensions.dart';

void main() {
  String codeOf(String? code) => AuthException('x', code: code).failureCode;

  test('maps server error codes to failure codes', () {
    expect(codeOf('invalid_credentials'), 'invalid-credential');
    expect(codeOf('user_already_exists'), 'email-already-in-use');
    expect(codeOf('email_exists'), 'email-already-in-use');
    expect(codeOf('weak_password'), 'weak-password');
    expect(codeOf('email_address_invalid'), 'invalid-email');
    expect(codeOf('otp_expired'), 'expired-action-code');
    expect(codeOf('over_email_send_rate_limit'), 'too-many-requests');
    expect(codeOf('user_banned'), 'user-disabled');
    expect(codeOf('session_not_found'), 'session-expired');
  });

  test('an unlisted or missing code is unknown', () {
    expect(codeOf('something_new'), 'unknown-error');
    expect(codeOf(null), 'unknown-error');
  });

  test('a failed request maps to a network failure', () {
    expect(AuthRetryableFetchException().failureCode, 'network-request-failed');
  });
}
