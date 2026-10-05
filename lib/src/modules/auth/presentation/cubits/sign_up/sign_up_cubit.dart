import '../../../../../core/presentation/blocs/process_cubit.dart';
import '../../../../../core/presentation/blocs/process_state.dart';
import '../../../domain/failures/auth_failures.dart';
import '../../../domain/use_cases/use_cases.dart';

typedef SignUpState = ProcessState<SignUpWithEmailAndPasswordFailure>;

class SignUpCubit extends ProcessCubit<SignUpWithEmailAndPasswordFailure> {
  final SignUpWithEmailAndPasswordUseCase _signUp;

  SignUpCubit({required SignUpWithEmailAndPasswordUseCase signUp})
    : _signUp = signUp;

  Future<void> submit({
    required String email,
    required String password,
    required String businessName,
  }) async {
    await run(
      () => _signUp(
        param: SignUpParam(
          email: email,
          password: password,
          businessName: businessName,
        ),
      ),
    );
  }
}
