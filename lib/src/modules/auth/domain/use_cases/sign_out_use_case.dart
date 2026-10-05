import 'package:fpdart/fpdart.dart';

import '../../../../core/use_cases/use_cases.dart';
import '../failures/auth_failures.dart';
import '../repositories/i_auth_repository.dart';

class SignOutUseCase implements UseCase<Unit, NoParam> {
  final IAuthRepository authRepository;

  const SignOutUseCase({required this.authRepository});

  @override
  Future<Either<SignOutFailure, Unit>> call({required NoParam param}) async {
    return await authRepository.signOut();
  }
}
