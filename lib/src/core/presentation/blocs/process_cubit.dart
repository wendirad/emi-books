import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../failures/failure.dart';
import 'process_state.dart';

/// A cubit that runs one use case on demand and reports it as a
/// [ProcessState]. Subclasses expose a `submit(...)` method that calls [run].
abstract class ProcessCubit<F extends Failure> extends Cubit<ProcessState<F>> {
  ProcessCubit() : super(ProcessState<F>.idle());

  /// Emits `inProgress`, runs [action], then `success` or `failure`. Does
  /// nothing after the cubit is closed, e.g. when the screen was left first.
  @protected
  Future<void> run(Future<Either<F, Unit>> Function() action) async {
    emit(ProcessState<F>.inProgress());

    final Either<F, Unit> result = await action();
    if (isClosed) return;

    emit(
      result.fold(ProcessState<F>.failure, (_) => ProcessState<F>.success()),
    );
  }
}
