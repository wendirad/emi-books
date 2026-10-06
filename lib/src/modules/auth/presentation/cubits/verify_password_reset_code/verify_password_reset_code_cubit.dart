import '../../../../../core/presentation/blocs/process_cubit.dart';
import '../../../../../core/presentation/blocs/process_state.dart';
import '../../../domain/failures/auth_failures.dart';
import '../../../domain/use_cases/use_cases.dart';

typedef VerifyPasswordResetCodeState =
    ProcessState<PasswordResetConfirmFailure>;

class VerifyPasswordResetCodeCubit
    extends ProcessCubit<PasswordResetConfirmFailure> {
  final VerifyPasswordResetCodeUseCase _verifyPasswordResetCode;

  VerifyPasswordResetCodeCubit({
    required VerifyPasswordResetCodeUseCase verifyPasswordResetCode,
  }) : _verifyPasswordResetCode = verifyPasswordResetCode;

  Future<void> submit({required String email, required String code}) async {
    await run(
      () => _verifyPasswordResetCode(
        param: VerifyPasswordResetCodeParam(email: email, code: code),
      ),
    );
  }
}
