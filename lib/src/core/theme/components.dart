import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart' as mui;

import 'app_colors.dart';
import 'palette.dart';

/// google_fonts 9 speaks `material_ui` types, so convert across the boundary.
TextTheme _poppins(TextTheme base) {
  final mui.TextTheme t = GoogleFonts.poppinsTextTheme(
    mui.TextTheme(
      displayLarge: base.displayLarge,
      displayMedium: base.displayMedium,
      displaySmall: base.displaySmall,
      headlineLarge: base.headlineLarge,
      headlineMedium: base.headlineMedium,
      headlineSmall: base.headlineSmall,
      titleLarge: base.titleLarge,
      titleMedium: base.titleMedium,
      titleSmall: base.titleSmall,
      bodyLarge: base.bodyLarge,
      bodyMedium: base.bodyMedium,
      bodySmall: base.bodySmall,
      labelLarge: base.labelLarge,
      labelMedium: base.labelMedium,
      labelSmall: base.labelSmall,
    ),
  );
  return TextTheme(
    displayLarge: t.displayLarge,
    displayMedium: t.displayMedium,
    displaySmall: t.displaySmall,
    headlineLarge: t.headlineLarge,
    headlineMedium: t.headlineMedium,
    headlineSmall: t.headlineSmall,
    titleLarge: t.titleLarge,
    titleMedium: t.titleMedium,
    titleSmall: t.titleSmall,
    bodyLarge: t.bodyLarge,
    bodyMedium: t.bodyMedium,
    bodySmall: t.bodySmall,
    labelLarge: t.labelLarge,
    labelMedium: t.labelMedium,
    labelSmall: t.labelSmall,
  );
}

ThemeData buildBaseTheme(ColorScheme scheme) {
  final isDark = scheme.brightness == Brightness.dark;

  final textTheme = Typography.material2021().black.apply(
    bodyColor: scheme.onSurface,
    displayColor: scheme.onSurface,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    brightness: scheme.brightness,
    extensions: [isDark ? AppColors.dark : AppColors.light],
    scaffoldBackgroundColor: scheme.surface,
    canvasColor: scheme.surface,
    splashFactory: InkSparkle.splashFactory,

    // Typography
    textTheme: _poppins(textTheme),

    // AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      centerTitle: false,
      surfaceTintColor: scheme.surfaceTint,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: scheme.onSurface,
      ),
      iconTheme: IconThemeData(color: scheme.onSurface),
    ),

    // Bottom Navigation
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: isDark ? scheme.surface : scheme.surfaceContainer,
      indicatorColor: scheme.primary.withValues(alpha: isDark ? 0.22 : 0.18),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return TextStyle(
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          color: selected
              ? scheme.onSurface
              : scheme.onSurface.withValues(alpha: .72),
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return IconThemeData(
          color: selected
              ? scheme.primary
              : scheme.onSurface.withValues(alpha: .72),
        );
      }),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size(48, 48)),
        shape: WidgetStateProperty.all(const StadiumBorder()),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return scheme.onSurface.withValues(alpha: .12);
          }
          return scheme.primary;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return scheme.onSurface.withValues(alpha: .38);
          }
          return scheme.onPrimary;
        }),
        overlayColor: WidgetStateProperty.all(
          scheme.onPrimary.withValues(alpha: .08),
        ),
        elevation: WidgetStateProperty.all(isDark ? 0 : 1),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size(48, 48)),
        shape: WidgetStateProperty.all(const StadiumBorder()),
        backgroundColor: WidgetStateProperty.all(scheme.secondaryContainer),
        foregroundColor: WidgetStateProperty.all(scheme.onSecondaryContainer),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size(48, 48)),
        shape: WidgetStateProperty.all(const StadiumBorder()),
        side: WidgetStateProperty.all(BorderSide(color: scheme.outline)),
        foregroundColor: WidgetStateProperty.all(scheme.primary),
        overlayColor: WidgetStateProperty.all(
          scheme.primary.withValues(alpha: .08),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(scheme.primary),
        overlayColor: WidgetStateProperty.all(
          scheme.primary.withValues(alpha: .08),
        ),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(scheme.onSurface),
        overlayColor: WidgetStateProperty.all(
          scheme.primary.withValues(alpha: .12),
        ),
      ),
    ),

    // FAB
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: scheme.primary,
      foregroundColor: scheme.onPrimary,
      elevation: isDark ? 1 : 3,
    ),

    // Inputs
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: isDark ? scheme.surfaceContainerHigh : scheme.surface,
      hintStyle: TextStyle(color: scheme.onSurface.withValues(alpha: .6)),
      labelStyle: TextStyle(color: scheme.onSurface.withValues(alpha: .9)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(color: scheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(color: scheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(color: scheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(color: scheme.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(color: scheme.error, width: 2),
      ),
    ),

    // Chips
    chipTheme: ChipThemeData(
      backgroundColor: isDark ? scheme.surfaceContainerHigh : scheme.surface,
      selectedColor: scheme.primary.withValues(alpha: isDark ? 0.28 : 0.18),
      disabledColor: scheme.onSurface.withValues(alpha: .12),
      labelStyle: TextStyle(color: scheme.onSurface),
      secondaryLabelStyle: TextStyle(color: scheme.onSecondaryContainer),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: scheme.outline),
      ),
    ),

    // Cards
    cardTheme: CardThemeData(
      elevation: 0,
      color: isDark ? scheme.surfaceContainerHigh : scheme.surface,
      surfaceTintColor: scheme.surfaceTint,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.outline.withValues(alpha: .6)),
      ),
      margin: const EdgeInsets.all(8),
    ),

    // Dialogs
    dialogTheme: DialogThemeData(
      backgroundColor: scheme.surface,
      surfaceTintColor: scheme.surfaceTint,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w700,
      ),
      contentTextStyle: textTheme.bodyMedium?.copyWith(color: scheme.onSurface),
    ),

    // Dividers
    dividerTheme: DividerThemeData(
      color: scheme.outline.withValues(alpha: .4),
      thickness: 1,
      space: 1,
    ),

    // ListTiles
    listTileTheme: ListTileThemeData(
      iconColor: scheme.onSurface.withValues(alpha: .8),
      textColor: scheme.onSurface,
      selectedTileColor: scheme.primary.withValues(alpha: isDark ? 0.18 : 0.12),
      selectedColor: scheme.primary,
    ),

    // SnackBars
    snackBarTheme: SnackBarThemeData(
      backgroundColor: isDark
          ? AppPalette.darkSurfaceDeep
          : AppPalette.darkSurfaceDeepest,
      contentTextStyle: textTheme.bodyMedium?.copyWith(
        color: AppPalette.lightCloud,
      ),
      actionTextColor: AppPalette.lightTone,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // Tooltips
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: scheme.onSurface.withValues(alpha: .9),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: textTheme.labelSmall?.copyWith(
        color: isDark ? AppPalette.darkSurfaceDeepest : AppPalette.lightCloud,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Progress
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: scheme.primary,
      linearTrackColor: scheme.outline.withValues(alpha: .3),
    ),

    // Selection controls
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return scheme.primary;
        return scheme.outline;
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return scheme.onPrimary;
        return scheme.outline;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return scheme.primary.withValues(alpha: .6);
        }
        return scheme.outline.withValues(alpha: .4);
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(scheme.primary),
    ),
  );
}
