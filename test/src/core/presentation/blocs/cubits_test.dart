// The package import carries the generated project name, which can sort
// differently from here.
// ignore_for_file: directives_ordering

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:emi_books/src/core/failures/failure.dart';
import 'package:emi_books/src/core/presentation/blocs/load_cubit.dart';
import 'package:emi_books/src/core/presentation/blocs/load_state.dart';
import 'package:emi_books/src/core/presentation/blocs/process_cubit.dart';
import 'package:emi_books/src/core/presentation/blocs/process_state.dart';

class _Oops extends Failure {
  const _Oops() : super(message: 'oops');
}

class _TestProcessCubit extends ProcessCubit<_Oops> {
  Future<void> submit(Future<Either<_Oops, Unit>> Function() action) =>
      run(action);
}

class _TestLoadCubit extends LoadCubit<int, _Oops> {
  Future<void> load(Future<Either<_Oops, int>> Function() action) =>
      fetch(action);
}

void main() {
  blocTest<_TestProcessCubit, ProcessState<_Oops>>(
    'ProcessCubit emits inProgress then success',
    build: _TestProcessCubit.new,
    act: (c) => c.submit(() async => const Right(unit)),
    expect: () => [
      ProcessState<_Oops>.inProgress(),
      ProcessState<_Oops>.success(),
    ],
  );

  blocTest<_TestProcessCubit, ProcessState<_Oops>>(
    'ProcessCubit emits inProgress then the failure',
    build: _TestProcessCubit.new,
    act: (c) => c.submit(() async => const Left(_Oops())),
    expect: () => [
      ProcessState<_Oops>.inProgress(),
      ProcessState<_Oops>.failure(const _Oops()),
    ],
  );

  test('ProcessCubit stays quiet when closed while the action runs', () async {
    final cubit = _TestProcessCubit();
    final done = Completer<Either<_Oops, Unit>>();

    final run = cubit.submit(() => done.future);
    await cubit.close();
    done.complete(const Right(unit));

    await expectLater(run, completes);
  });

  blocTest<_TestLoadCubit, LoadState<int, _Oops>>(
    'LoadCubit emits inProgress then the data',
    build: _TestLoadCubit.new,
    act: (c) => c.load(() async => const Right(7)),
    expect: () => [
      LoadState<int, _Oops>.inProgress(),
      LoadState<int, _Oops>.success(7),
    ],
  );

  blocTest<_TestLoadCubit, LoadState<int, _Oops>>(
    'LoadCubit emits inProgress then the failure',
    build: _TestLoadCubit.new,
    act: (c) => c.load(() async => const Left(_Oops())),
    expect: () => [
      LoadState<int, _Oops>.inProgress(),
      LoadState<int, _Oops>.failure(const _Oops()),
    ],
  );
}
