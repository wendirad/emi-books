part of 'auth_session_bloc.dart';

sealed class AuthSessionEvent extends Equatable {
  const AuthSessionEvent();

  @override
  List<Object> get props => [];
}

class AuthSessionUserSubscriptionRequested extends AuthSessionEvent {
  const AuthSessionUserSubscriptionRequested();
}
