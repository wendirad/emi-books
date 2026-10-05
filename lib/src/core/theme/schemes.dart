import 'package:flutter/material.dart';

import 'palette.dart';

class AppColorSchemes {
  static const ColorScheme light = ColorScheme(
    brightness: Brightness.light,
    primary: AppPalette.brand,
    onPrimary: Colors.white,
    primaryContainer: AppPalette.lightDeep,
    onPrimaryContainer: AppPalette.darkSurfaceDeepest,

    secondary: AppPalette.brandDeep,
    onSecondary: Colors.white,
    secondaryContainer: AppPalette.lavender,
    onSecondaryContainer: AppPalette.darkSurfaceDeepest,

    tertiary: AppPalette.brandSoft,
    onTertiary: Colors.white,
    tertiaryContainer: AppPalette.lavenderLight,
    onTertiaryContainer: AppPalette.darkSurfaceDeepest,

    error: AppPalette.errorLight,
    onError: Colors.white,
    errorContainer: AppPalette.errorContainerLight,
    onErrorContainer: AppPalette.onErrorContainerLight,

    surface: Colors.white,
    onSurface: AppPalette.darkSurfaceDeepest,
    surfaceContainerHighest: AppPalette.mist,
    surfaceContainerHigh: AppPalette.mistDeep,
    surfaceContainer: AppPalette.lightSoft,
    surfaceContainerLow: AppPalette.mistDeep,
    surfaceContainerLowest: Colors.white,
    surfaceBright: Colors.white,
    surfaceDim: AppPalette.mistDim,

    outline: AppPalette.lightTone,
    outlineVariant: AppPalette.lavender,

    inverseSurface: AppPalette.darkSurfaceDeepest,
    onInverseSurface: AppPalette.lightCloud,
    inversePrimary: AppPalette.brandDeep,

    shadow: Colors.black,
    scrim: Colors.black,

    surfaceTint: AppPalette.brand,
  );

  static const ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,
    primary: AppPalette.brandLight,
    onPrimary: AppPalette.darkSurfaceDeepest,
    primaryContainer: AppPalette.brandMuted,
    onPrimaryContainer: AppPalette.lightCloud,

    secondary: AppPalette.brandMuted,
    onSecondary: AppPalette.lightCloud,
    secondaryContainer: AppPalette.darkSurface,
    onSecondaryContainer: AppPalette.lightCloud,

    tertiary: AppPalette.lightTone,
    onTertiary: AppPalette.darkSurfaceDeepest,
    tertiaryContainer: AppPalette.darkSurface,
    onTertiaryContainer: AppPalette.lightCloud,

    error: AppPalette.errorDark,
    onError: AppPalette.onErrorDark,
    errorContainer: AppPalette.errorContainerDark,
    onErrorContainer: AppPalette.onErrorContainerDark,

    surface: AppPalette.darkSurfaceDeep,
    onSurface: AppPalette.lightCloud,
    surfaceContainerHighest: AppPalette.darkSurface,
    surfaceContainerHigh: AppPalette.darkSurfaceHigh,
    surfaceContainer: AppPalette.darkSurfaceDeep,
    surfaceContainerLow: AppPalette.darkSurfaceDeepest,
    surfaceContainerLowest: AppPalette.darkSurfaceDeepest,
    surfaceBright: AppPalette.darkSurfaceDeep,
    surfaceDim: AppPalette.darkSurfaceDeepest,

    outline: AppPalette.darkOutline,
    outlineVariant: AppPalette.darkOutlineVariant,

    inverseSurface: AppPalette.lightCloud,
    onInverseSurface: AppPalette.darkSurfaceDeepest,
    inversePrimary: AppPalette.brand,

    shadow: Colors.black,
    scrim: Colors.black,

    surfaceTint: AppPalette.brandLight,
  );
}
