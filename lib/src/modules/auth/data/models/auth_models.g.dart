// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUserModel _$AuthUserModelFromJson(Map<String, dynamic> json) =>
    AuthUserModel(
      uid: json['uid'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      creationTime: AuthUserModel._fromTimestamp(
        json['creationTime'] as Timestamp?,
      ),
      lastSignInTime: AuthUserModel._fromTimestamp(
        json['lastSignInTime'] as Timestamp?,
      ),
      lastUpdateTime: AuthUserModel._fromTimestamp(
        json['lastUpdateTime'] as Timestamp?,
      ),
    );

Map<String, dynamic> _$AuthUserModelToJson(AuthUserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'creationTime': AuthUserModel._toTimestamp(instance.creationTime),
      'lastSignInTime': AuthUserModel._toTimestamp(instance.lastSignInTime),
      'lastUpdateTime': AuthUserModel._toTimestamp(instance.lastUpdateTime),
    };

BusinessUserModel _$BusinessUserModelFromJson(Map<String, dynamic> json) =>
    BusinessUserModel(
      businessName: json['businessName'] as String,
      uid: json['uid'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      creationTime: AuthUserModel._fromTimestamp(
        json['creationTime'] as Timestamp?,
      ),
      lastSignInTime: AuthUserModel._fromTimestamp(
        json['lastSignInTime'] as Timestamp?,
      ),
      lastUpdateTime: AuthUserModel._fromTimestamp(
        json['lastUpdateTime'] as Timestamp?,
      ),
    );

Map<String, dynamic> _$BusinessUserModelToJson(BusinessUserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'creationTime': AuthUserModel._toTimestamp(instance.creationTime),
      'lastSignInTime': AuthUserModel._toTimestamp(instance.lastSignInTime),
      'lastUpdateTime': AuthUserModel._toTimestamp(instance.lastUpdateTime),
      'businessName': instance.businessName,
    };

AdminAuthUserModel _$AdminAuthUserModelFromJson(Map<String, dynamic> json) =>
    AdminAuthUserModel(
      uid: json['uid'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      creationTime: AuthUserModel._fromTimestamp(
        json['creationTime'] as Timestamp?,
      ),
      lastSignInTime: AuthUserModel._fromTimestamp(
        json['lastSignInTime'] as Timestamp?,
      ),
      lastUpdateTime: AuthUserModel._fromTimestamp(
        json['lastUpdateTime'] as Timestamp?,
      ),
    );

Map<String, dynamic> _$AdminAuthUserModelToJson(AdminAuthUserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'creationTime': AuthUserModel._toTimestamp(instance.creationTime),
      'lastSignInTime': AuthUserModel._toTimestamp(instance.lastSignInTime),
      'lastUpdateTime': AuthUserModel._toTimestamp(instance.lastUpdateTime),
    };
