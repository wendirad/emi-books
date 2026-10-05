import '../../../../../core/presentation/blocs/load_cubit.dart';
import '../../../../../core/presentation/blocs/load_state.dart';
import '../../../../../core/use_cases/use_cases.dart';
import '../../../domain/entities/auth_entities.dart';
import '../../../domain/failures/auth_failures.dart';
import '../../../domain/use_cases/use_cases.dart';

typedef CurrentUserState = LoadState<AuthUser, AuthSessionFailure>;

class CurrentUserCubit extends LoadCubit<AuthUser, AuthSessionFailure> {
  final GetCurrentUserUseCase _getCurrentUser;

  CurrentUserCubit({required GetCurrentUserUseCase getCurrentUser})
    : _getCurrentUser = getCurrentUser;

  Future<void> load() async {
    await fetch(() => _getCurrentUser(param: const NoParam()));
  }
}
