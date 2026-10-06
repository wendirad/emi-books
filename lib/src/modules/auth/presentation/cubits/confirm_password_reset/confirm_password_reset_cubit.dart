import '../../../../../core/presentation/blocs/process_cubit.dart';
import '../../../../../core/presentation/blocs/process_state.dart';
import '../../../domain/failures/auth_failures.dart';
import '../../../domain/use_cases/use_cases.dart';

typedef ConfirmPasswordResetState = ProcessState<PasswordResetConfirmFailure>;

class ConfirmPasswordResetCubit
    extends ProcessCubit<PasswordResetConfirmFailure> {
  final ConfirmPasswordResetUseCase _confirmPasswordReset;

  ConfirmPasswordResetCubit({
    required ConfirmPasswordResetUseCase confirmPasswordReset,
  }) : _confirmPasswordReset = confirmPasswordReset;

  Future<void> submit({required String newPassword}) async {
    await run(
      () => _confirmPasswordReset(
        param: ConfirmPasswordResetParam(newPassword: newPassword),
      ),
    );
  }
}
