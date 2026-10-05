import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/use_cases/use_cases.dart';
import '../failures/auth_failures.dart';
import '../repositories/i_auth_repository.dart';

class SignUpWithEmailAndPasswordUseCase implements UseCase<Unit, SignUpParam> {
  final IAuthRepository authRepository;

  SignUpWithEmailAndPasswordUseCase({required this.authRepository});

  @override
  Future<Either<SignUpWithEmailAndPasswordFailure, Unit>> call({
    required SignUpParam param,
  }) async {
    return await authRepository.signUpWithEmailAndPassword(
      email: param.email,
      password: param.password,
      businessName: param.businessName,
    );
  }
}

class SignUpParam extends Equatable {
  final String email;
  final String password;
  final String businessName;

  const SignUpParam({
    required this.email,
    required this.password,
    required this.businessName,
  });

  @override
  List<Object?> get props => [email, password, businessName];
}
