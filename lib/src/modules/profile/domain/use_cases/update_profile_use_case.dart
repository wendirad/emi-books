import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/use_cases/use_cases.dart';
import '../failures/profile_failures.dart';
import '../repositories/i_profile_repository.dart';

class UpdateProfileUseCase implements UseCase<Unit, UpdateProfileParam> {
  final IProfileRepository profileRepository;

  UpdateProfileUseCase({required this.profileRepository});

  @override
  Future<Either<ProfileUpdateFailure, Unit>> call({
    required UpdateProfileParam param,
  }) async {
    return profileRepository.updateProfile(
      businessName: param.businessName,
      firstName: param.firstName,
      lastName: param.lastName,
      profilePicture: param.profilePicture,
      removeProfilePicture: param.removeProfilePicture,
    );
  }
}

class UpdateProfileParam extends Equatable {
  final String? businessName;
  final String? firstName;
  final String? lastName;
  final File? profilePicture;
  final bool removeProfilePicture;

  const UpdateProfileParam({
    this.businessName,
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.removeProfilePicture = false,
  });

  @override
  List<Object?> get props => [
    businessName,
    firstName,
    lastName,
    profilePicture,
    removeProfilePicture,
  ];
}
