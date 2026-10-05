import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/use_cases/use_cases.dart';
import '../failures/auth_failures.dart';
import '../repositories/i_auth_repository.dart';

class VerifyPasswordResetCodeUseCase
    implements UseCase<bool, VerifyPasswordResetCodeParam> {
  final IAuthRepository authRepository;

  VerifyPasswordResetCodeUseCase({required this.authRepository});

  @override
  Future<Either<PasswordResetConfirmFailure, bool>> call({
    required VerifyPasswordResetCodeParam param,
  }) {
    return authRepository.verifyPasswordResetCode(code: param.code);
  }
}

class VerifyPasswordResetCodeParam extends Equatable {
  final String code;

  const VerifyPasswordResetCodeParam({required this.code});

  @override
  List<Object?> get props => [code];
}
