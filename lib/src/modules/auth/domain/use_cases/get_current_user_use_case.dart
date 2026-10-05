import 'package:fpdart/fpdart.dart';

import '../../../../core/use_cases/use_cases.dart';
import '../entities/auth_entities.dart';
import '../failures/auth_failures.dart';
import '../repositories/i_auth_repository.dart';

class GetCurrentUserUseCase implements UseCase<AuthUser, NoParam> {
  final IAuthRepository authRepository;

  const GetCurrentUserUseCase({required this.authRepository});

  @override
  Future<Either<AuthSessionFailure, AuthUser>> call({required NoParam param}) {
    return authRepository.getSignedInUser();
  }
}
