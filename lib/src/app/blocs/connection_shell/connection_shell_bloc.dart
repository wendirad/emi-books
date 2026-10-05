import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'connection_shell_event.dart';
part 'connection_shell_state.dart';

class ConnectionShellBloc
    extends Bloc<ConnectionShellEvent, ConnectionShellState> {
  final InternetConnection _connection;
  final Duration _gracePeriod;
  Timer? _lostTimer;

  /// A drop in connectivity only counts as "off" after [gracePeriod], so a
  /// brief blip does not replace the screen with the no-connection view.
  ConnectionShellBloc({
    InternetConnection? connection,
    Duration gracePeriod = const Duration(seconds: 5),
  }) : _connection = connection ?? InternetConnection(),
       _gracePeriod = gracePeriod,
       super(ConnectionShellState.initial) {
    on<ConnectionStatusSubscriptionRequested>(_onSubscriptionRequested);
    on<ConnectionStatusChanged>(_onStatusChanged);
    on<ConnectionLost>(_onConnectionLost);
  }

  Future<void> _onSubscriptionRequested(
    ConnectionStatusSubscriptionRequested event,
    Emitter<ConnectionShellState> emit,
  ) async {
    final hasInternet = await _connection.hasInternetAccess;
    emit(
      state.copyWith(
        status: hasInternet ? ConnectionStatus.on : ConnectionStatus.off,
      ),
    );

    await emit.onEach<InternetStatus>(
      _connection.onStatusChange,
      onData: (status) =>
          add(ConnectionStatusChanged(status == InternetStatus.connected)),
    );
  }

  void _onStatusChanged(
    ConnectionStatusChanged event,
    Emitter<ConnectionShellState> emit,
  ) {
    if (event.hasInternet) {
      _lostTimer?.cancel();
      _lostTimer = null;
      emit(state.copyWith(status: ConnectionStatus.on));
    } else {
      _lostTimer ??= Timer(_gracePeriod, () => add(const ConnectionLost()));
    }
  }

  void _onConnectionLost(
    ConnectionLost event,
    Emitter<ConnectionShellState> emit,
  ) {
    _lostTimer = null;
    emit(state.copyWith(status: ConnectionStatus.off));
  }

  @override
  Future<void> close() {
    _lostTimer?.cancel();
    return super.close();
  }
}
