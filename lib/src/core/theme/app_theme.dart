import 'package:flutter/material.dart';

import 'components.dart';
import 'schemes.dart';

class AppTheme {
  static ThemeData light() => buildBaseTheme(AppColorSchemes.light);
  static ThemeData dark() => buildBaseTheme(AppColorSchemes.dark);
}
