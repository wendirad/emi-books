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
      creationTime: json['creationTime'] == null
          ? null
          : DateTime.parse(json['creationTime'] as String),
      lastSignInTime: json['lastSignInTime'] == null
          ? null
          : DateTime.parse(json['lastSignInTime'] as String),
      lastUpdateTime: json['lastUpdateTime'] == null
          ? null
          : DateTime.parse(json['lastUpdateTime'] as String),
    );

Map<String, dynamic> _$AuthUserModelToJson(AuthUserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'creationTime': instance.creationTime?.toIso8601String(),
      'lastSignInTime': instance.lastSignInTime?.toIso8601String(),
      'lastUpdateTime': instance.lastUpdateTime?.toIso8601String(),
    };

BusinessUserModel _$BusinessUserModelFromJson(Map<String, dynamic> json) =>
    BusinessUserModel(
      businessName: json['businessName'] as String,
      uid: json['uid'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      creationTime: json['creationTime'] == null
          ? null
          : DateTime.parse(json['creationTime'] as String),
      lastSignInTime: json['lastSignInTime'] == null
          ? null
          : DateTime.parse(json['lastSignInTime'] as String),
      lastUpdateTime: json['lastUpdateTime'] == null
          ? null
          : DateTime.parse(json['lastUpdateTime'] as String),
    );

Map<String, dynamic> _$BusinessUserModelToJson(BusinessUserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'creationTime': instance.creationTime?.toIso8601String(),
      'lastSignInTime': instance.lastSignInTime?.toIso8601String(),
      'lastUpdateTime': instance.lastUpdateTime?.toIso8601String(),
      'businessName': instance.businessName,
    };

AdminAuthUserModel _$AdminAuthUserModelFromJson(Map<String, dynamic> json) =>
    AdminAuthUserModel(
      uid: json['uid'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      creationTime: json['creationTime'] == null
          ? null
          : DateTime.parse(json['creationTime'] as String),
      lastSignInTime: json['lastSignInTime'] == null
          ? null
          : DateTime.parse(json['lastSignInTime'] as String),
      lastUpdateTime: json['lastUpdateTime'] == null
          ? null
          : DateTime.parse(json['lastUpdateTime'] as String),
    );

Map<String, dynamic> _$AdminAuthUserModelToJson(AdminAuthUserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'creationTime': instance.creationTime?.toIso8601String(),
      'lastSignInTime': instance.lastSignInTime?.toIso8601String(),
      'lastUpdateTime': instance.lastUpdateTime?.toIso8601String(),
    };
