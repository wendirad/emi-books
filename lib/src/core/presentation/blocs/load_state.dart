import 'package:equatable/equatable.dart';

import '../../failures/failure.dart';
import 'process_state.dart';

/// State of a bloc that loads one value: nothing yet, loading, loaded with
/// [data], or failed with a [Failure]. Blocs expose it through a typedef, e.g.
/// `typedef CurrentUserState = LoadState<AuthUser, AuthSessionFailure>;`.
class LoadState<T, F extends Failure> extends Equatable {
  final ProcessStatus status;
  final T? data;
  final F? failure;

  const LoadState.idle()
    : status = ProcessStatus.idle,
      data = null,
      failure = null;

  const LoadState.inProgress()
    : status = ProcessStatus.inProgress,
      data = null,
      failure = null;

  const LoadState.success(T this.data)
    : status = ProcessStatus.success,
      failure = null;

  const LoadState.failure(F this.failure)
    : status = ProcessStatus.failure,
      data = null;

  bool get isIdle => status == ProcessStatus.idle;
  bool get isInProgress => status == ProcessStatus.inProgress;
  bool get isSuccess => status == ProcessStatus.success;
  bool get isFailure => status == ProcessStatus.failure;

  @override
  List<Object?> get props => [status, ?data, ?failure];
}
