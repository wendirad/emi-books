import 'package:flutter/material.dart';

import 'palette.dart';

/// Colors the Material [ColorScheme] has no slot for. Read them with
/// `context.appColors`.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color success;
  final Color onSuccess;

  /// Translucent chip background for controls drawn over imagery.
  final Color overlay;
  final Color onOverlay;

  const AppColors({
    required this.success,
    required this.onSuccess,
    required this.overlay,
    required this.onOverlay,
  });

  static const AppColors light = AppColors(
    success: AppPalette.success,
    onSuccess: AppPalette.onSuccess,
    overlay: AppPalette.overlay,
    onOverlay: AppPalette.onOverlay,
  );

  static const AppColors dark = AppColors(
    success: AppPalette.successDark,
    onSuccess: AppPalette.onSuccessDark,
    overlay: AppPalette.overlay,
    onOverlay: AppPalette.onOverlay,
  );

  @override
  AppColors copyWith({
    Color? success,
    Color? onSuccess,
    Color? overlay,
    Color? onOverlay,
  }) {
    return AppColors(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      overlay: overlay ?? this.overlay,
      onOverlay: onOverlay ?? this.onOverlay,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      overlay: Color.lerp(overlay, other.overlay, t)!,
      onOverlay: Color.lerp(onOverlay, other.onOverlay, t)!,
    );
  }
}
