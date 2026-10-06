import 'package:fpdart/fpdart.dart';

import '../entities/auth_entities.dart';
import '../failures/auth_failures.dart';

abstract class IAuthRepository {
  bool get isAuthenticated;

  Future<Either<AuthSessionFailure, Stream<bool>>> get authStateChanges;

  Future<Either<AuthSessionFailure, AuthUser>> getSignedInUser();

  /// The email saved by 'remember my email', or null when none is saved.
  Future<Either<AuthSessionFailure, String?>> getRememberedEmail();

  Future<Either<SignUpWithEmailAndPasswordFailure, Unit>>
  signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String businessName,
  });

  Future<Either<SignInWithEmailAndPasswordFailure, Unit>>
  signInWithEmailAndPassword({
    required String email,
    required String password,
    required bool saveInfo,
  });

  Future<Either<PasswordResetFailure, Unit>> sendPasswordResetEmail({
    required String email,
  });

  /// Checks the 6 digit code sent to [email]. On success the repository holds
  /// a recovery session, which [confirmPasswordReset] uses.
  Future<Either<PasswordResetConfirmFailure, Unit>> verifyPasswordResetCode({
    required String email,
    required String code,
  });

  Future<Either<PasswordResetConfirmFailure, Unit>> confirmPasswordReset({
    required String newPassword,
  });

  Future<Either<SignOutFailure, Unit>> signOut();
}
