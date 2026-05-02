import 'package:flutter/material.dart';

import 'colors.dart';
import 'spacing.dart';
import 'typography.dart';

/// Builds the application's `ThemeData` from the design tokens.
///
/// The marine theme is dark-first: deep marine blue surfaces with high-contrast
/// white text, designed to read on a boat helm in direct sunlight (TDD §10.1).
ThemeData buildMarineTheme() {
  const colorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: MarineColors.actionTeal,
    onPrimary: MarineColors.onDark,
    primaryContainer: MarineColors.actionTeal,
    onPrimaryContainer: MarineColors.onDark,
    secondary: MarineColors.warnAmber,
    onSecondary: MarineColors.deepMarine,
    secondaryContainer: MarineColors.warnAmber,
    onSecondaryContainer: MarineColors.deepMarine,
    surface: MarineColors.deepMarine,
    onSurface: MarineColors.onDark,
    surfaceContainerHighest: MarineColors.surfaceElevated,
    onSurfaceVariant: MarineColors.onDark,
    error: Color(0xFFCF6679),
    onError: MarineColors.onDark,
    outline: MarineColors.divider,
  );

  const textTheme = TextTheme(
    displayLarge: MarineTypography.cardScoreNumeral,
    headlineLarge: MarineTypography.headingLarge,
    headlineMedium: MarineTypography.headingMedium,
    headlineSmall: MarineTypography.headingSmall,
    titleLarge: MarineTypography.headingMedium,
    titleMedium: MarineTypography.headingSmall,
    titleSmall: MarineTypography.label,
    bodyLarge: MarineTypography.bodyLarge,
    bodyMedium: MarineTypography.bodyMedium,
    bodySmall: MarineTypography.bodySmall,
    labelLarge: MarineTypography.label,
    labelMedium: MarineTypography.label,
    labelSmall: MarineTypography.bodySmall,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: MarineColors.deepMarine,
    canvasColor: MarineColors.deepMarine,
    textTheme: textTheme.apply(
      bodyColor: MarineColors.onDark,
      displayColor: MarineColors.onDark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: MarineColors.deepMarine,
      foregroundColor: MarineColors.onDark,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: MarineTypography.headingMedium,
    ),
    cardTheme: const CardTheme(
      color: MarineColors.surfaceElevated,
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(MarineSpacing.radiusLg)),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: MarineColors.divider,
      thickness: MarineSpacing.hairline,
      space: MarineSpacing.lg,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MarineColors.actionTeal,
        foregroundColor: MarineColors.onDark,
        minimumSize: const Size.fromHeight(MarineSpacing.touchPhone),
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(MarineSpacing.radiusMd)),
        ),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: MarineColors.actionTeal,
      foregroundColor: MarineColors.onDark,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: MarineColors.surfaceElevated,
      modalBackgroundColor: MarineColors.surfaceElevated,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(MarineSpacing.radiusLg),
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: MarineColors.onDark,
      size: 24,
    ),
  );
}
