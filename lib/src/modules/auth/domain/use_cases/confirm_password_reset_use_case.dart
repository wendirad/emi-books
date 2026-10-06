import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/use_cases/use_cases.dart';
import '../failures/auth_failures.dart';
import '../repositories/i_auth_repository.dart';

class ConfirmPasswordResetUseCase
    implements UseCase<Unit, ConfirmPasswordResetParam> {
  final IAuthRepository authRepository;

  ConfirmPasswordResetUseCase({required this.authRepository});

  @override
  Future<Either<PasswordResetConfirmFailure, Unit>> call({
    required ConfirmPasswordResetParam param,
  }) async {
    return await authRepository.confirmPasswordReset(
      newPassword: param.newPassword,
    );
  }
}

class ConfirmPasswordResetParam extends Equatable {
  final String newPassword;

  const ConfirmPasswordResetParam({required this.newPassword});

  @override
  List<Object?> get props => [newPassword];
}
