import '../../../../../core/presentation/blocs/process_cubit.dart';
import '../../../../../core/presentation/blocs/process_state.dart';
import '../../../../../core/use_cases/use_cases.dart';
import '../../../domain/failures/auth_failures.dart';
import '../../../domain/use_cases/use_cases.dart';

typedef SignOutState = ProcessState<SignOutFailure>;

class SignOutCubit extends ProcessCubit<SignOutFailure> {
  final SignOutUseCase _signOut;

  SignOutCubit({required SignOutUseCase signOut}) : _signOut = signOut;

  Future<void> submit() async {
    await run(() => _signOut(param: const NoParam()));
  }
}
