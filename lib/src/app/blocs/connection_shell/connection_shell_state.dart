part of 'connection_shell_bloc.dart';

enum ConnectionStatus { idle, on, off }

class ConnectionShellState extends Equatable {
  final ConnectionStatus status;

  const ConnectionShellState({required this.status});

  static ConnectionShellState get initial =>
      ConnectionShellState(status: ConnectionStatus.idle);

  ConnectionShellState copyWith({ConnectionStatus? status}) {
    return ConnectionShellState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
