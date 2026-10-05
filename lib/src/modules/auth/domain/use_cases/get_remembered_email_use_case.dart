import 'package:fpdart/fpdart.dart';

import '../../../../core/use_cases/use_cases.dart';
import '../failures/auth_failures.dart';
import '../repositories/i_auth_repository.dart';

class GetRememberedEmailUseCase implements UseCase<String?, NoParam> {
  final IAuthRepository authRepository;

  const GetRememberedEmailUseCase({required this.authRepository});

  @override
  Future<Either<AuthSessionFailure, String?>> call({required NoParam param}) {
    return authRepository.getRememberedEmail();
  }
}
