part of 'auth_session_bloc.dart';

// Sentinel so copyWith can tell "keep the failure" from an explicit null.
const Object _unset = Object();

enum SessionStatus { initial, authenticated, unauthenticated }

class AuthSessionState extends Equatable {
  final SessionStatus status;
  final AuthSessionFailure? failure;

  const AuthSessionState({required this.status, this.failure});

  static AuthSessionState initial() =>
      AuthSessionState(status: SessionStatus.initial);

  bool get isAuthenticated => status == SessionStatus.authenticated;

  AuthSessionState copyWith({SessionStatus? status, Object? failure = _unset}) {
    return AuthSessionState(
      status: status ?? this.status,
      failure: identical(failure, _unset)
          ? this.failure
          : failure as AuthSessionFailure?,
    );
  }

  @override
  List<Object> get props => [status, ?failure];
}
