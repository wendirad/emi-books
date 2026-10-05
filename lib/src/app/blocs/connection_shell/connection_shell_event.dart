part of 'connection_shell_bloc.dart';

sealed class ConnectionShellEvent extends Equatable {
  const ConnectionShellEvent();

  @override
  List<Object?> get props => [];
}

class ConnectionStatusSubscriptionRequested extends ConnectionShellEvent {
  const ConnectionStatusSubscriptionRequested();
}

class ConnectionStatusChanged extends ConnectionShellEvent {
  final bool hasInternet;

  const ConnectionStatusChanged(this.hasInternet);

  @override
  List<Object?> get props => [hasInternet];
}

/// The grace period after a disconnect elapsed without reconnecting.
class ConnectionLost extends ConnectionShellEvent {
  const ConnectionLost();
}
