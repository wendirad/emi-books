import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String uid;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? photoUrl;
  final DateTime? creationTime;
  final DateTime? lastSignInTime;
  final DateTime? lastUpdateTime;

  const AuthUser({
    required this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.photoUrl,
    this.creationTime,
    this.lastSignInTime,
    this.lastUpdateTime,
  });

  String get _fullName => '${firstName ?? ""} ${lastName ?? ""}'.trim();

  String get emailUsername => (email ?? '@').split('@').first;

  String get displayName => _fullName.isEmpty ? emailUsername : _fullName;

  String get initials {
    final parts = displayName.trim().split(' ');
    if (parts.isEmpty) return 'U';
    if (parts.length == 1) {
      return parts[0].isNotEmpty ? parts[0][0].toUpperCase() : 'U';
    }
    return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
  }

  static AuthUser empty() => AuthUser(uid: '');

  bool get isEmpty => this == AuthUser.empty();

  AdminUser admin() => AdminUser(
    uid: uid,
    firstName: firstName,
    lastName: lastName,
    email: email,
    photoUrl: photoUrl,
    creationTime: creationTime,
    lastSignInTime: lastSignInTime,
    lastUpdateTime: lastUpdateTime,
  );

  BusinessUser asBusinessUser({required String businessName}) => BusinessUser(
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
}

class BusinessUser extends AuthUser {
  final String businessName;

  const BusinessUser({
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

  @override
  String get displayName =>
      businessName.isNotEmpty ? businessName : emailUsername;
}

class AdminUser extends AuthUser {
  const AdminUser({
    required super.uid,
    super.firstName,
    super.lastName,
    super.email,
    super.photoUrl,
    super.creationTime,
    super.lastSignInTime,
    super.lastUpdateTime,
  });
}
