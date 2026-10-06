import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/auth_entities.dart';

part 'auth_models.g.dart';

@JsonSerializable()
class AuthUserModel extends AuthUser with Equatable {
  AuthUserModel({
    required super.uid,
    super.firstName,
    super.lastName,
    super.email,
    super.photoUrl,
    this.creationTime,
    this.lastSignInTime,
    this.lastUpdateTime,
  });

  // ignore: annotate_overrides, overridden_fields
  final DateTime? creationTime;

  @override
  // ignore: annotate_overrides, overridden_fields
  final DateTime? lastSignInTime;

  @override
  // ignore: annotate_overrides, overridden_fields
  final DateTime? lastUpdateTime;

  @override
  List<Object?> get props => [
    uid,
    firstName,
    lastName,
    email,
    photoUrl,
    creationTime,
    lastSignInTime,
    lastUpdateTime,
  ];

  AuthUserModel copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    String? email,
    String? photoUrl,
    DateTime? creationTime,
    DateTime? lastSignInTime,
    DateTime? lastUpdateTime,
  }) {
    return AuthUserModel(
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      creationTime: creationTime ?? this.creationTime,
      lastSignInTime: lastSignInTime ?? this.lastSignInTime,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
    );
  }

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthUserModelToJson(this);

  AuthUser entity() => this as AuthUser;
}

@JsonSerializable()
class BusinessUserModel extends AuthUserModel {
  final String businessName;

  BusinessUserModel({
    required this.businessName,
    required super.uid,
    super.firstName,
    super.lastName,
    super.email,
    super.photoUrl,
    super.creationTime,
    super.lastSignInTime,
    super.lastUpdateTime,
  });

  @override
  List<Object?> get props => [businessName, ...super.props];

  factory BusinessUserModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessUserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BusinessUserModelToJson(this);

  @override
  BusinessUser entity() => BusinessUser(
    businessName: businessName,
    uid: uid,
    firstName: firstName,
    lastName: lastName,
    email: email,
    photoUrl: photoUrl,
    creationTime: creationTime,
    lastSignInTime: lastSignInTime,
    lastUpdateTime: lastUpdateTime,
  );
}

@JsonSerializable()
@JsonSerializable()
class AdminAuthUserModel extends AuthUserModel {
  AdminAuthUserModel({
    required super.uid,
    super.firstName,
    super.lastName,
    super.email,
    super.photoUrl,
    super.creationTime,
    super.lastSignInTime,
    super.lastUpdateTime,
  });

  factory AdminAuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AdminAuthUserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdminAuthUserModelToJson(this);

  @override
  AdminUser entity() => AdminUser(
    uid: uid,
    firstName: firstName,
    lastName: lastName,
    email: email,
    photoUrl: photoUrl,
    creationTime: creationTime,
    lastSignInTime: lastSignInTime,
    lastUpdateTime: lastUpdateTime,
  );
}
