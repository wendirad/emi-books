import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/constants/constants.dart';

/// Lets a request through only when it carries a reset-password action.
String? passwordResetGuard(RouteState state) {
  final Object? arguments = state.arguments;
  final bool isReset = arguments is Map && arguments['mode'] == 'resetPassword';
  return isReset ? null : AppRoute.resetPassword.str;
}
