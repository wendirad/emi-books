import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/constants/constants.dart';
import 'data/repositories/auth_repository.dart';
import 'domain/repositories/i_auth_repository.dart';
import 'domain/use_cases/use_cases.dart';
import 'presentation/guards/guards.dart';
import 'presentation/views/views.dart';

final Module _authRoutes = createModule(
  register: (c) {
    c
      ..route(AppRoute.signUp.base, child: (_, _) => SignUpView())
      ..route(AppRoute.signIn.base, child: (_, _) => SignInView())
      ..route(AppRoute.resetPassword.base, child: (_, _) => PasswordResetView())
      ..route(
        AppRoute.confirmPasswordReset.base,
        child: (_, _) => ConfirmPasswordResetView(),
        guards: [passwordResetGuard],
      );
  },
);

/// Auth dependencies, root-owned because the app shell and settings use them.
/// Register inside the `/app` children; the routes mount at `/app/auth/...`.
final Module authModule = createModule(
  register: (c) {
    c.addLazySingleton<IAuthRepository>(
      () => AuthRepository(
        auth: inject<FirebaseAuth>(),
        store: inject<FirebaseFirestore>(),
        storage: inject<FirebaseStorage>(),
      ),
    );

    c.addLazySingleton<SignUpWithEmailAndPasswordUseCase>(
      () => SignUpWithEmailAndPasswordUseCase(
        authRepository: inject<IAuthRepository>(),
      ),
    );

    c.addLazySingleton<SignInWithEmailAndPasswordUseCase>(
      () => SignInWithEmailAndPasswordUseCase(
        authRepository: inject<IAuthRepository>(),
      ),
    );

    c.addLazySingleton<SendPasswordResetEmailUseCase>(
      () => SendPasswordResetEmailUseCase(
        authRepository: inject<IAuthRepository>(),
      ),
    );

    c.addLazySingleton<VerifyPasswordResetCodeUseCase>(
      () => VerifyPasswordResetCodeUseCase(
        authRepository: inject<IAuthRepository>(),
      ),
    );

    c.addLazySingleton<ConfirmPasswordResetUseCase>(
      () => ConfirmPasswordResetUseCase(
        authRepository: inject<IAuthRepository>(),
      ),
    );

    c.addLazySingleton<GetCurrentUserUseCase>(
      () => GetCurrentUserUseCase(
        authRepository: inject<IAuthRepository>(),
      ),
    );

    c.addLazySingleton<GetRememberedEmailUseCase>(
      () => GetRememberedEmailUseCase(
        authRepository: inject<IAuthRepository>(),
      ),
    );

    c.addLazySingleton<ObserveAuthSessionUseCase>(
      () => ObserveAuthSessionUseCase(
        authRepository: inject<IAuthRepository>(),
      ),
    );

    c.addLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(authRepository: inject<IAuthRepository>()),
    );

    c.module(_authRoutes, at: AppRoute.auth.base);
  },
);
