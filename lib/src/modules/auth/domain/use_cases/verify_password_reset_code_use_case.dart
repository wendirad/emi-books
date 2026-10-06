import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/use_cases/use_cases.dart';
import '../failures/auth_failures.dart';
import '../repositories/i_auth_repository.dart';

class VerifyPasswordResetCodeUseCase
    implements UseCase<Unit, VerifyPasswordResetCodeParam> {
  final IAuthRepository authRepository;

  VerifyPasswordResetCodeUseCase({required this.authRepository});

  @override
  Future<Either<PasswordResetConfirmFailure, Unit>> call({
    required VerifyPasswordResetCodeParam param,
  }) {
    return authRepository.verifyPasswordResetCode(
      email: param.email,
      code: param.code,
    );
  }
}

class VerifyPasswordResetCodeParam extends Equatable {
  final String email;
  final String code;

  const VerifyPasswordResetCodeParam({required this.email, required this.code});

  @override
  List<Object?> get props => [email, code];
}
