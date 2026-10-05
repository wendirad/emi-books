import '../../../../../core/presentation/blocs/load_cubit.dart';
import '../../../../../core/presentation/blocs/load_state.dart';
import '../../../../../core/use_cases/use_cases.dart';
import '../../../domain/failures/auth_failures.dart';
import '../../../domain/use_cases/use_cases.dart';

/// `data` is the saved email, or null when nothing is saved.
typedef RememberedEmailState = LoadState<String?, AuthSessionFailure>;

class RememberedEmailCubit extends LoadCubit<String?, AuthSessionFailure> {
  final GetRememberedEmailUseCase _getRememberedEmail;

  RememberedEmailCubit({required GetRememberedEmailUseCase getRememberedEmail})
    : _getRememberedEmail = getRememberedEmail;

  Future<void> load() async {
    await fetch(() => _getRememberedEmail(param: const NoParam()));
  }
}
