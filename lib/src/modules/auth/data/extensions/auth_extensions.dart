import 'package:firebase_auth/firebase_auth.dart';

import '../models/auth_models.dart';

extension AuthUserMapperExtensions on User {
  /// [photoUrl] overrides the stored photo (e.g. with a resolved download URL).
  AuthUserModel toModel({String? photoUrl}) {
    return AuthUserModel(
      uid: uid,
      email: email,
      creationTime: metadata.creationTime,
      lastSignInTime: metadata.lastSignInTime,
      photoUrl: photoUrl ?? photoURL,
    );
  }
}
