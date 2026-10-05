// The package import carries the generated project name, which can sort
// differently from here.
// ignore_for_file: directives_ordering

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mocktail/mocktail.dart';
import 'package:emi_books/src/app/blocs/connection_shell/connection_shell_bloc.dart';

class MockInternetConnection extends Mock implements InternetConnection {}

void main() {
  late MockInternetConnection connection;
  late StreamController<InternetStatus> statuses;

  const grace = Duration(milliseconds: 30);
  const on = ConnectionShellState(status: ConnectionStatus.on);
  const off = ConnectionShellState(status: ConnectionStatus.off);

  setUp(() {
    connection = MockInternetConnection();
    statuses = StreamController<InternetStatus>();
    when(() => connection.hasInternetAccess).thenAnswer((_) async => true);
    when(() => connection.onStatusChange).thenAnswer((_) => statuses.stream);
  });

  tearDown(() => statuses.close());

  ConnectionShellBloc build() =>
      ConnectionShellBloc(connection: connection, gracePeriod: grace);

  blocTest<ConnectionShellBloc, ConnectionShellState>(
    'reports the starting connectivity',
    build: build,
    act: (bloc) => bloc.add(const ConnectionStatusSubscriptionRequested()),
    expect: () => [on],
  );

  blocTest<ConnectionShellBloc, ConnectionShellState>(
    'reports off only after the grace period',
    build: build,
    act: (bloc) async {
      bloc.add(const ConnectionStatusSubscriptionRequested());
      await Future<void>.delayed(const Duration(milliseconds: 10));
      statuses.add(InternetStatus.disconnected);
    },
    wait: const Duration(milliseconds: 120),
    expect: () => [on, off],
  );

  blocTest<ConnectionShellBloc, ConnectionShellState>(
    'a reconnect within the grace period never reports off',
    build: build,
    act: (bloc) async {
      bloc.add(const ConnectionStatusSubscriptionRequested());
      await Future<void>.delayed(const Duration(milliseconds: 10));
      statuses.add(InternetStatus.disconnected);
      await Future<void>.delayed(const Duration(milliseconds: 5));
      statuses.add(InternetStatus.connected);
    },
    wait: const Duration(milliseconds: 120),
    expect: () => [on],
  );
}
