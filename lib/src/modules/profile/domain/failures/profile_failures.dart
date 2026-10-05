import '../../../../core/failures/failure.dart';
import '../../../../core/failures/failure_messages.dart';

class ProfileUpdateFailure extends Failure {
  const ProfileUpdateFailure({required super.message, super.code});

  factory ProfileUpdateFailure.fromCode(String? code) => ProfileUpdateFailure(
    code: code,
    message: failureMessageFor(
      code,
      const {},
      fallback: 'An unknown error occurred while updating profile.',
    ),
  );
}
