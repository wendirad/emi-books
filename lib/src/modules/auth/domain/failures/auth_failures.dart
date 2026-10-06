import '../../../../core/failures/failure.dart';
import '../../../../core/failures/failure_messages.dart';

class AuthSessionFailure extends Failure {
  const AuthSessionFailure({required super.message, super.code});

  static const Map<String, String> _messages = {
    'session-expired': 'Your session has expired. Please sign in again.',
    'invalid-session-cookie': 'The session cookie is invalid.',
    'token-revoked': 'The session has been revoked. Please sign in again.',
  };

  factory AuthSessionFailure.fromCode(String? code) => AuthSessionFailure(
    code: code,
    message: failureMessageFor(code, _messages),
  );
}

class SignUpWithEmailAndPasswordFailure extends Failure {
  const SignUpWithEmailAndPasswordFailure({required super.message, super.code});

  static const Map<String, String> _messages = {
    'invalid-email': 'Email is not valid or badly formatted.',
    'email-already-in-use': 'An account already exists for that email.',
    'weak-password': 'Please enter a stronger password.',
    'invalid-credential': 'The supplied credential is invalid or has expired.',
    'account-exists-with-different-credential':
        'An account already exists with a different sign-in method.',
    'credential-already-in-use':
        'This credential is already associated with a different user account.',
  };

  factory SignUpWithEmailAndPasswordFailure.fromCode(String? code) =>
      SignUpWithEmailAndPasswordFailure(
        code: code,
        message: failureMessageFor(code, _messages),
      );
}

class SignInWithEmailAndPasswordFailure extends Failure {
  const SignInWithEmailAndPasswordFailure({required super.message, super.code});

  static const Map<String, String> _messages = {
    'invalid-email': 'Email is not valid or badly formatted.',
  };

  // Wrong password and unknown email share one message so the screen does not
  // reveal which accounts exist.
  factory SignInWithEmailAndPasswordFailure.fromCode(String? code) =>
      SignInWithEmailAndPasswordFailure(
        code: code,
        message: failureMessageFor(
          code,
          _messages,
          fallback: 'Please make sure your email and password are correct.',
        ),
      );
}

class PasswordResetFailure extends Failure {
  const PasswordResetFailure({required super.message, super.code});

  factory PasswordResetFailure.fromCode(String? code) => PasswordResetFailure(
    code: code,
    message: failureMessageFor(code, const {}),
  );
}

class PasswordResetConfirmFailure extends Failure {
  const PasswordResetConfirmFailure({required super.message, super.code});

  static const Map<String, String> _messages = {
    'expired-action-code': 'The code is wrong or has expired.',
    'invalid-action-code': 'The code is invalid or has already been used.',
    'user-not-found': 'No user corresponding to the code was found.',
    'weak-password': 'The new password is not strong enough.',
  };

  factory PasswordResetConfirmFailure.fromCode(String? code) =>
      PasswordResetConfirmFailure(
        code: code,
        message: failureMessageFor(code, _messages),
      );
}

class SignOutFailure extends Failure {
  const SignOutFailure({required super.message, super.code});

  factory SignOutFailure.fromCode(String? code) => SignOutFailure(
    code: code,
    message: failureMessageFor(
      code,
      const {},
      fallback: 'An unknown error occurred while signing out.',
    ),
  );
}
