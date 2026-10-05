import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mime/mime.dart';

import '../../../../core/constants/constants.dart';
import '../../domain/failures/profile_failures.dart';
import '../../domain/repositories/i_profile_repository.dart';

class ProfileRepository implements IProfileRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore store;
  final FirebaseStorage storage;

  const ProfileRepository({
    required this.auth,
    required this.store,
    required this.storage,
  });

  @override
  Future<Either<ProfileUpdateFailure, Unit>> updateProfile({
    String? businessName,
    String? firstName,
    String? lastName,
    File? profilePicture,
    bool removeProfilePicture = false,
  }) async {
    try {
      await auth.currentUser?.reload();
      final User? user = auth.currentUser;

      if (user == null) {
        return Left(ProfileUpdateFailure.fromCode('no-current-user'));
      }

      if (profilePicture != null) {
        final String format = profilePicture.path.split('.').last;
        final String refName =
            '${StoragePaths.profilePicture}${user.uid}.$format';

        await _uploadProfilePhoto(profilePicture, refName);

        final String photoUrl = 'gs://${storage.bucket}/$refName';

        await user.updatePhotoURL(photoUrl);
      } else if (removeProfilePicture) {
        await user.updatePhotoURL(null);
      }

      final DocumentSnapshot<Map<String, dynamic>> userDoc = await store
          .collection(FirestoreCollections.user)
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        final Map<String, dynamic> updateData = {
          'lastUpdateTime': FieldValue.serverTimestamp(),
        };

        if (businessName != null) {
          updateData['businessName'] = businessName;
        }

        if (firstName != null) {
          updateData['firstName'] = firstName;
        }

        if (lastName != null) {
          updateData['lastName'] = lastName;
        }

        await store
            .collection(FirestoreCollections.user)
            .doc(user.uid)
            .update(updateData);
      }

      return Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(ProfileUpdateFailure.fromCode(e.code));
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: '$e');
      return Left(ProfileUpdateFailure.fromCode('unknown-error'));
    }
  }

  Future<void> _uploadProfilePhoto(File profilePicture, String refName) async {
    final profilePictureRef = storage.ref().child(refName);

    try {
      await profilePictureRef.delete();
    } catch (_) {
      // Nothing to replace on the first upload.
    }

    await profilePictureRef.putFile(
      profilePicture.absolute,
      SettableMetadata(contentType: lookupMimeType(profilePicture.path)),
    );
  }
}
