import 'dart:io';

import '../../../../../core/presentation/blocs/process_cubit.dart';
import '../../../../../core/presentation/blocs/process_state.dart';
import '../../../domain/failures/profile_failures.dart';
import '../../../domain/use_cases/use_cases.dart';

typedef UpdateProfileState = ProcessState<ProfileUpdateFailure>;

class UpdateProfileCubit extends ProcessCubit<ProfileUpdateFailure> {
  final UpdateProfileUseCase _updateProfile;

  UpdateProfileCubit({required UpdateProfileUseCase updateProfile})
    : _updateProfile = updateProfile;

  Future<void> submit({
    String? businessName,
    String? firstName,
    String? lastName,
    File? profilePicture,
    bool removeProfilePicture = false,
  }) async {
    await run(
      () => _updateProfile(
        param: UpdateProfileParam(
          businessName: businessName,
          firstName: firstName,
          lastName: lastName,
          profilePicture: profilePicture,
          removeProfilePicture: removeProfilePicture,
        ),
      ),
    );
  }
}
