import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/auth_models.dart';

extension AuthUserMapperExtensions on User {
  /// [photoUrl] is the signed URL of the stored profile photo, if any.
  AuthUserModel toModel({String? photoUrl}) {
    return AuthUserModel(
      uid: id,
      email: email,
      creationTime: DateTime.tryParse(createdAt),
      lastSignInTime: lastSignInAt == null
          ? null
          : DateTime.tryParse(lastSignInAt!),
      photoUrl: photoUrl,
    );
  }
}
