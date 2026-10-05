import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/constants/constants.dart';
import '../../domain/repositories/i_auth_repository.dart';

/// Redirects to sign-in when there is no session.
String? authGuard(RouteState state) {
  return inject<IAuthRepository>().isAuthenticated
      ? null
      : AppRoute.signIn.str;
}
