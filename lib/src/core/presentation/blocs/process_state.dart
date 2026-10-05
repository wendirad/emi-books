import 'package:equatable/equatable.dart';

import '../../failures/failure.dart';

enum ProcessStatus { idle, inProgress, success, failure }

/// State of a bloc that runs one use case: nothing yet, running, done, or
/// failed with a [Failure]. Blocs expose it through a typedef, e.g.
/// `typedef SignInState = ProcessState<SignInWithEmailAndPasswordFailure>;`.
class ProcessState<F extends Failure> extends Equatable {
  final ProcessStatus status;
  final F? failure;

  const ProcessState.idle() : status = ProcessStatus.idle, failure = null;

  const ProcessState.inProgress()
    : status = ProcessStatus.inProgress,
      failure = null;

  const ProcessState.success() : status = ProcessStatus.success, failure = null;

  const ProcessState.failure(F this.failure) : status = ProcessStatus.failure;

  bool get isIdle => status == ProcessStatus.idle;
  bool get isInProgress => status == ProcessStatus.inProgress;
  bool get isSuccess => status == ProcessStatus.success;
  bool get isFailure => status == ProcessStatus.failure;

  @override
  List<Object?> get props => [status, ?failure];
}
