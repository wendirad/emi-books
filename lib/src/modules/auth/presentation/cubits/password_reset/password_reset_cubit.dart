import '../../../../../core/presentation/blocs/process_cubit.dart';
import '../../../../../core/presentation/blocs/process_state.dart';
import '../../../domain/failures/auth_failures.dart';
import '../../../domain/use_cases/use_cases.dart';

typedef PasswordResetState = ProcessState<PasswordResetFailure>;

class PasswordResetCubit extends ProcessCubit<PasswordResetFailure> {
  final SendPasswordResetEmailUseCase _sendPasswordResetEmail;

  PasswordResetCubit({
    required SendPasswordResetEmailUseCase sendPasswordResetEmail,
  }) : _sendPasswordResetEmail = sendPasswordResetEmail;

  Future<void> submit({required String email}) async {
    await run(
      () => _sendPasswordResetEmail(
        param: SendPasswordResetEmailParam(email: email),
      ),
    );
  }
}
