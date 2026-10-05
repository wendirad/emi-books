import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../failures/profile_failures.dart';

abstract class IProfileRepository {
  Future<Either<ProfileUpdateFailure, Unit>> updateProfile({
    String? businessName,
    String? firstName,
    String? lastName,
    File? profilePicture,
    bool removeProfilePicture,
  });
}
