import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/use_cases/use_cases.dart';
import '../failures/auth_failures.dart';
import '../repositories/i_auth_repository.dart';

class SignInWithEmailAndPasswordUseCase implements UseCase<Unit, SignInParam> {
  final IAuthRepository authRepository;

  const SignInWithEmailAndPasswordUseCase({required this.authRepository});

  @override
  Future<Either<SignInWithEmailAndPasswordFailure, Unit>> call({
    required param,
  }) async {
    return await authRepository.signInWithEmailAndPassword(
      email: param.email,
      password: param.password,
      saveInfo: param.saveInfo,
    );
  }
}

class SignInParam extends Equatable {
  final String email;
  final String password;
  final bool saveInfo;

  const SignInParam({
    required this.email,
    required this.password,
    required this.saveInfo,
  });

  @override
  List<Object?> get props => [email, password, saveInfo];
}
