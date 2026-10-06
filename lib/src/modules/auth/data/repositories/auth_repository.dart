import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

import '../../../../core/constants/constants.dart';
import '../../domain/entities/auth_entities.dart';
import '../../domain/failures/auth_failures.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../extensions/auth_exception_extensions.dart';
import '../extensions/auth_extensions.dart';
import '../models/auth_models.dart';

class AuthRepository implements IAuthRepository {
  static const int _photoUrlLifetimeSeconds = 3600;

  final SupabaseClient client;

  const AuthRepository({required this.client});

  GoTrueClient get _auth => client.auth;

  @override
  bool get isAuthenticated => _auth.currentSession != null;

  @override
  Future<Either<AuthSessionFailure, Stream<bool>>> get authStateChanges async {
    try {
      return Right(
        _auth.onAuthStateChange.map((AuthState state) => state.session != null),
      );
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: '$e');
      return Left(AuthSessionFailure.fromCode('internal-error'));
    }
  }

  @override
  Future<Either<SignUpWithEmailAndPasswordFailure, Unit>>
  signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String businessName,
  }) async {
    try {
      await _auth.signUp(
        email: email,
        password: password,
        data: {'business_name': businessName},
      );

      return Right(unit);
    } on AuthException catch (e) {
      debugPrint('Sign up failed: $e');
      return Left(SignUpWithEmailAndPasswordFailure.fromCode(e.failureCode));
    } catch (_, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      return Left(SignUpWithEmailAndPasswordFailure.fromCode('unknown-error'));
    }
  }

  @override
  Future<Either<SignInWithEmailAndPasswordFailure, Unit>>
  signInWithEmailAndPassword({
    required String email,
    required String password,
    required bool saveInfo,
  }) async {
    try {
      await _auth.signInWithPassword(email: email, password: password);

      final prefs = await SharedPreferences.getInstance();

      if (saveInfo) {
        await prefs.setBool(PrefKeys.signInInfoSave, true);
        await prefs.setString(PrefKeys.rememberedEmail, email);
      } else {
        await prefs.setBool(PrefKeys.signInInfoSave, false);
        await prefs.remove(PrefKeys.rememberedEmail);
      }

      // Passwords are never persisted. Clear any value stored by older builds.
      await prefs.remove(PrefKeys.legacyPassword);

      return Right(unit);
    } on AuthException catch (e) {
      return Left(SignInWithEmailAndPasswordFailure.fromCode(e.failureCode));
    } catch (e, stackTrace) {
      debugPrint('Error SignIn: $e');
      debugPrintStack(stackTrace: stackTrace);
      return Left(SignInWithEmailAndPasswordFailure.fromCode('unknown-error'));
    }
  }

  @override
  Future<Either<PasswordResetFailure, Unit>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await _auth.resetPasswordForEmail(email);

      return Right(unit);
    } on AuthException catch (e) {
      if (e.failureCode == 'user-not-found') return Right(unit);
      return Left(PasswordResetFailure.fromCode(e.failureCode));
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: '$e');
      return Left(PasswordResetFailure.fromCode('unknown-error'));
    }
  }

  @override
  Future<Either<PasswordResetConfirmFailure, Unit>> verifyPasswordResetCode({
    required String email,
    required String code,
  }) async {
    try {
      await _auth.verifyOTP(type: OtpType.recovery, email: email, token: code);
      return Right(unit);
    } on AuthException catch (e) {
      return Left(
        PasswordResetConfirmFailure.fromCode(
          e.code == 'validation_failed' ? 'invalid-action-code' : e.failureCode,
        ),
      );
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: '$e');
      return Left(PasswordResetConfirmFailure.fromCode('invalid-action-code'));
    }
  }

  @override
  Future<Either<PasswordResetConfirmFailure, Unit>> confirmPasswordReset({
    required String newPassword,
  }) async {
    try {
      await _auth.updateUser(UserAttributes(password: newPassword));
      await _auth.signOut();
      return Right(unit);
    } on AuthException catch (e) {
      return Left(PasswordResetConfirmFailure.fromCode(e.failureCode));
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: '$e');
      return Left(PasswordResetConfirmFailure.fromCode('unknown-error'));
    }
  }

  @override
  Future<Either<AuthSessionFailure, AuthUser>> getSignedInUser() async {
    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        return Left(AuthSessionFailure.fromCode('no-current-user'));
      }

      final Map<String, dynamic>? profile = await client
          .from(SupabaseTables.profiles)
          .select()
          .eq('id', user.id)
          .maybeSingle();

      final AuthUserModel userDomain = user.toModel(
        photoUrl: await _resolvePhotoUrl(profile?['photo_path'] as String?),
      );

      if (profile == null) return Right(userDomain.entity());

      final AuthUserModel profileUser = userDomain.copyWith(
        firstName: profile['first_name'] as String?,
        lastName: profile['last_name'] as String?,
        lastUpdateTime: DateTime.tryParse(
          profile['updated_at'] as String? ?? '',
        ),
      );

      final String email = (user.email ?? '').toLowerCase();
      final Map<String, dynamic>? admin = await client
          .from(SupabaseTables.admins)
          .select('email')
          .eq('email', email)
          .maybeSingle();

      if (admin != null) {
        return Right(
          AdminAuthUserModel(
            uid: profileUser.uid,
            firstName: profileUser.firstName,
            lastName: profileUser.lastName,
            email: profileUser.email,
            photoUrl: profileUser.photoUrl,
            creationTime: profileUser.creationTime,
            lastSignInTime: profileUser.lastSignInTime,
            lastUpdateTime: profileUser.lastUpdateTime,
          ).entity(),
        );
      }

      return Right(
        BusinessUserModel(
          businessName: profile['business_name'] as String? ?? '',
          uid: profileUser.uid,
          firstName: profileUser.firstName,
          lastName: profileUser.lastName,
          email: profileUser.email,
          photoUrl: profileUser.photoUrl,
          creationTime: profileUser.creationTime,
          lastSignInTime: profileUser.lastSignInTime,
          lastUpdateTime: profileUser.lastUpdateTime,
        ).entity(),
      );
    } on AuthException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      return Left(AuthSessionFailure.fromCode(e.failureCode));
    } catch (e, stackTrace) {
      if (e is PostgrestException) await signOut();

      debugPrintStack(stackTrace: stackTrace, label: '$e');
      return Left(AuthSessionFailure.fromCode('unknown-error'));
    }
  }

  @override
  Future<Either<AuthSessionFailure, String?>> getRememberedEmail() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (!(prefs.getBool(PrefKeys.signInInfoSave) ?? false)) {
        return const Right(null);
      }

      return Right(prefs.getString(PrefKeys.rememberedEmail));
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: '$e');
      return Left(AuthSessionFailure.fromCode('unknown-error'));
    }
  }

  @override
  Future<Either<SignOutFailure, Unit>> signOut() async {
    try {
      await _auth.signOut();
      return Right(unit);
    } on AuthException catch (e) {
      return Left(SignOutFailure.fromCode(e.failureCode));
    } catch (_, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      return Left(SignOutFailure.fromCode('internal-error'));
    }
  }

  /// Turns a stored object path into a signed URL, or null if it cannot be
  /// resolved (no photo, or the object is gone).
  Future<String?> _resolvePhotoUrl(String? path) async {
    if (path == null || path.isEmpty) return null;

    try {
      return await client.storage
          .from(StoragePaths.profilePicturesBucket)
          .createSignedUrl(path, _photoUrlLifetimeSeconds);
    } catch (e) {
      debugPrint('Could not resolve profile photo: $e');
      return null;
    }
  }
}
