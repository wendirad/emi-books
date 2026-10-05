// The package import carries the generated project name, which can sort
// differently from here.
// ignore_for_file: directives_ordering

import 'package:flutter_test/flutter_test.dart';
import 'package:emi_books/src/modules/auth/domain/failures/auth_failures.dart';

void main() {
  test('a failure uses its own message before the shared one', () {
    final failure = SignUpWithEmailAndPasswordFailure.fromCode(
      'email-already-in-use',
    );

    expect(failure.code, 'email-already-in-use');
    expect(failure.message, 'An account already exists for that email.');
  });

  test('shared codes resolve for every failure', () {
    const code = 'network-request-failed';

    expect(
      SignInWithEmailAndPasswordFailure.fromCode(code).message,
      AuthSessionFailure.fromCode(code).message,
    );
    expect(
      SignOutFailure.fromCode(code).message,
      PasswordResetConfirmFailure.fromCode(code).message,
    );
  });

  test('sign-in hides whether the email or the password was wrong', () {
    expect(
      SignInWithEmailAndPasswordFailure.fromCode('wrong-password').message,
      SignInWithEmailAndPasswordFailure.fromCode('user-not-found').message,
    );
  });

  test('a null or unknown code falls back to the default message', () {
    expect(PasswordResetFailure.fromCode(null).message, isNotEmpty);
  });
}
