import '../../../../../core/presentation/blocs/process_cubit.dart';
import '../../../../../core/presentation/blocs/process_state.dart';
import '../../../domain/failures/auth_failures.dart';
import '../../../domain/use_cases/use_cases.dart';

typedef SignInState = ProcessState<SignInWithEmailAndPasswordFailure>;

class SignInCubit extends ProcessCubit<SignInWithEmailAndPasswordFailure> {
  final SignInWithEmailAndPasswordUseCase _signIn;

  SignInCubit({required SignInWithEmailAndPasswordUseCase signIn})
    : _signIn = signIn;

  Future<void> submit({
    required String email,
    required String password,
    required bool saveInfo,
  }) async {
    await run(
      () => _signIn(
        param: SignInParam(
          email: email,
          password: password,
          saveInfo: saveInfo,
        ),
      ),
    );
  }
}
