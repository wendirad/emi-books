import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../failures/failure.dart';
import 'load_state.dart';

/// A cubit that loads one value on demand and reports it as a [LoadState].
/// Subclasses expose a `load()` method that calls [fetch].
abstract class LoadCubit<T, F extends Failure> extends Cubit<LoadState<T, F>> {
  LoadCubit() : super(LoadState<T, F>.idle());

  /// Emits `inProgress`, runs [action], then `success` with the value or
  /// `failure`. Does nothing after the cubit is closed.
  @protected
  Future<void> fetch(Future<Either<F, T>> Function() action) async {
    emit(LoadState<T, F>.inProgress());

    final Either<F, T> result = await action();
    if (isClosed) return;

    emit(result.fold(LoadState<T, F>.failure, LoadState<T, F>.success));
  }
}
