import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constants/constants.dart';
import '../../domain/failures/profile_failures.dart';
import '../../domain/repositories/i_profile_repository.dart';

class ProfileRepository implements IProfileRepository {
  final SupabaseClient client;

  const ProfileRepository({required this.client});

  @override
  Future<Either<ProfileUpdateFailure, Unit>> updateProfile({
    String? businessName,
    String? firstName,
    String? lastName,
    File? profilePicture,
    bool removeProfilePicture = false,
  }) async {
    try {
      final User? user = client.auth.currentUser;

      if (user == null) {
        return Left(ProfileUpdateFailure.fromCode('no-current-user'));
      }

      final Map<String, dynamic> updateData = {};

      if (businessName != null) updateData['business_name'] = businessName;
      if (firstName != null) updateData['first_name'] = firstName;
      if (lastName != null) updateData['last_name'] = lastName;

      final bucket = client.storage.from(StoragePaths.profilePicturesBucket);

      String? previousPath;
      if (profilePicture != null || removeProfilePicture) {
        final Map<String, dynamic>? row = await client
            .from(SupabaseTables.profiles)
            .select('photo_path')
            .eq('id', user.id)
            .maybeSingle();
        previousPath = row?['photo_path'] as String?;
      }

      if (profilePicture != null) {
        final String format = profilePicture.path.split('.').last;
        final String path = '${user.id}/profile.$format';

        await bucket.upload(
          path,
          profilePicture.absolute,
          fileOptions: FileOptions(
            upsert: true,
            contentType: lookupMimeType(profilePicture.path),
          ),
        );

        updateData['photo_path'] = path;
      } else if (removeProfilePicture) {
        updateData['photo_path'] = null;
      }

      if (updateData.isNotEmpty) {
        await client
            .from(SupabaseTables.profiles)
            .update(updateData)
            .eq('id', user.id);
      }

      final String? newPath = updateData['photo_path'] as String?;
      if (previousPath != null && previousPath != newPath) {
        await _removeQuietly(bucket, previousPath);
      }

      return Right(unit);
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: '$e');
      return Left(ProfileUpdateFailure.fromCode('unknown-error'));
    }
  }

  Future<void> _removeQuietly(StorageFileApi bucket, String path) async {
    try {
      await bucket.remove([path]);
    } catch (e) {
      debugPrint('Could not remove previous profile photo: $e');
    }
  }
}
