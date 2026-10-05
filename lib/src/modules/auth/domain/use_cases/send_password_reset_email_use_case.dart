import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/use_cases/use_cases.dart';
import '../failures/auth_failures.dart';
import '../repositories/i_auth_repository.dart';

class SendPasswordResetEmailUseCase
    implements UseCase<Unit, SendPasswordResetEmailParam> {
  final IAuthRepository authRepository;

  SendPasswordResetEmailUseCase({required this.authRepository});

  @override
  Future<Either<PasswordResetFailure, Unit>> call({
    required SendPasswordResetEmailParam param,
  }) async {
    return await authRepository.sendPasswordResetEmail(email: param.email);
  }
}

class SendPasswordResetEmailParam extends Equatable {
  final String email;

  const SendPasswordResetEmailParam({required this.email});

  @override
  List<Object?> get props => [email];
}
