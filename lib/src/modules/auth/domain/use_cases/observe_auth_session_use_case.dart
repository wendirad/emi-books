import 'package:fpdart/fpdart.dart';

import '../../../../core/use_cases/use_cases.dart';
import '../failures/auth_failures.dart';
import '../repositories/i_auth_repository.dart';

/// Emits `true` while a user is signed in and `false` once signed out.
class ObserveAuthSessionUseCase implements UseCase<Stream<bool>, NoParam> {
  final IAuthRepository authRepository;

  const ObserveAuthSessionUseCase({required this.authRepository});

  @override
  Future<Either<AuthSessionFailure, Stream<bool>>> call({
    required NoParam param,
  }) {
    return authRepository.authStateChanges;
  }
}
