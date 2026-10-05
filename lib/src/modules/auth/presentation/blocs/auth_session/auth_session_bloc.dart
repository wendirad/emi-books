import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/use_cases/use_cases.dart';
import '../../../domain/failures/auth_failures.dart';
import '../../../domain/use_cases/use_cases.dart';

part 'auth_session_event.dart';
part 'auth_session_state.dart';

class AuthSessionBloc extends Bloc<AuthSessionEvent, AuthSessionState> {
  final ObserveAuthSessionUseCase _observeAuthSession;

  AuthSessionBloc({required ObserveAuthSessionUseCase observeAuthSession})
    : _observeAuthSession = observeAuthSession,
      super(AuthSessionState.initial()) {
    on<AuthSessionUserSubscriptionRequested>(
      _onSessionUserSubscriptionRequested,
    );
  }

  Future<void> _onSessionUserSubscriptionRequested(
    AuthSessionUserSubscriptionRequested event,
    Emitter<AuthSessionState> emit,
  ) async {
    final result = await _observeAuthSession(param: const NoParam());

    await result.fold(
      (failure) async => emit(
        state.copyWith(status: SessionStatus.unauthenticated, failure: failure),
      ),
      (signedInChanges) => emit.onEach<bool>(
        signedInChanges,
        onData: (signedIn) => emit(
          state.copyWith(
            status: signedIn
                ? SessionStatus.authenticated
                : SessionStatus.unauthenticated,
            failure: null,
          ),
        ),
        onError: addError,
      ),
    );
  }
}
