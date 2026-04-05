import 'package:flutter/material.dart';

/// Professional banking app color palette
class AppColors {
  // Primary brand colors
  static const Color primary = Color(0xFF0B4D78);
  static const Color primaryLight = Color(0xFF1A6B9A);
  static const Color primaryDark = Color(0xFF063550);
  static const Color primaryContainer = Color(0xFFE3F2FD);

  // Secondary/Accent colors
  static const Color secondary = Color(0xFF00C9A7);
  static const Color secondaryLight = Color(0xFF4DFFD9);
  static const Color secondaryDark = Color(0xFF00977C);
  static const Color secondaryContainer = Color(0xFFE0F2F1);

  // Accent colors for alerts and highlights
  static const Color accent = Color(0xFFFF6B6B);
  static const Color accentLight = Color(0xFFFF8A8A);
  static const Color accentContainer = Color(0xFFFFEBEE);

  // Neutral colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);
  static const Color outline = Color(0xFFE2E8F0);
  static const Color outlineVariant = Color(0xFFCBD5E1);

  // Text colors
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textInverse = Color(0xFFFFFFFF);

  // Semantic colors
  static const Color success = Color(0xFF10B981);
  static const Color successContainer = Color(0xFFD1FAE5);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningContainer = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFEF4444);
  static const Color errorContainer = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoContainer = Color(0xFFDBEAFE);

  // Gradient colors for cards
  static const List<Color> primaryGradient = [
    Color(0xFF0B4D78),
    Color(0xFF1A6B9A),
  ];
  static const List<Color> secondaryGradient = [
    Color(0xFF00C9A7),
    Color(0xFF4DFFD9),
  ];

  // Shadow colors
  static const Color shadowColor = Color(0x1A000000);
  static const Color cardShadow = Color(0x0A0B4D78);
}

/// Light theme colors extension
extension LightThemeColors on AppColors {
  static const ColorScheme lightScheme = ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: AppColors.textInverse,
    primaryContainer: AppColors.primaryContainer,
    onPrimaryContainer: AppColors.primaryDark,
    secondary: AppColors.secondary,
    onSecondary: AppColors.textInverse,
    secondaryContainer: AppColors.secondaryContainer,
    onSecondaryContainer: AppColors.secondaryDark,
    tertiary: AppColors.accent,
    onTertiary: AppColors.textInverse,
    tertiaryContainer: AppColors.accentContainer,
    onTertiaryContainer: AppColors.primaryDark,
    error: AppColors.error,
    onError: AppColors.textInverse,
    errorContainer: AppColors.errorContainer,
    onErrorContainer: AppColors.error,
    background: AppColors.background,
    onBackground: AppColors.textPrimary,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    surfaceVariant: AppColors.surfaceVariant,
    onSurfaceVariant: AppColors.textSecondary,
    outline: AppColors.outline,
    outlineVariant: AppColors.outlineVariant,
    inverseSurface: AppColors.textPrimary,
    onInverseSurface: AppColors.surface,
    inversePrimary: AppColors.primaryLight,
  );
}

/// Dark theme colors extension
extension DarkThemeColors on AppColors {
  static const ColorScheme darkScheme = ColorScheme.dark(
    primary: AppColors.primaryLight,
    onPrimary: AppColors.textInverse,
    primaryContainer: AppColors.primaryDark,
    onPrimaryContainer: AppColors.primaryContainer,
    secondary: AppColors.secondaryLight,
    onSecondary: AppColors.textPrimary,
    secondaryContainer: AppColors.secondaryDark,
    onSecondaryContainer: AppColors.secondaryContainer,
    tertiary: AppColors.accentLight,
    onTertiary: AppColors.textPrimary,
    tertiaryContainer: AppColors.primaryDark,
    onTertiaryContainer: AppColors.accentContainer,
    error: Color(0xFFFF6B6B),
    onError: AppColors.textPrimary,
    errorContainer: Color(0xFF7F1D1D),
    onErrorContainer: Color(0xFFFEE2E2),
    background: Color(0xFF0F172A),
    onBackground: AppColors.surface,
    surface: Color(0xFF1E293B),
    onSurface: AppColors.surface,
    surfaceVariant: Color(0xFF334155),
    onSurfaceVariant: Color(0xFFCBD5E1),
    outline: Color(0xFF475569),
    outlineVariant: Color(0xFF334155),
    inverseSurface: AppColors.surface,
    onInverseSurface: AppColors.textPrimary,
    inversePrimary: AppColors.primary,
  );
}
