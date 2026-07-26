import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Échelle typographique. Une seule famille système lisible, des poids
/// tranchés (400 / 600 / 700) et des tailles généreuses : l'app est utilisée
/// sur le terrain, souvent par des personnes peu habituées au numérique.
abstract final class AppTypography {
  const AppTypography._();

  static TextTheme textThemeFor(Color primary, Color secondary) {
    return TextTheme(
      // Titres d'écran
      displaySmall: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        height: 1.15,
        color: primary,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: primary,
        letterSpacing: -0.3,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.25,
        color: primary,
      ),
      // Titres de section / carte
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: primary,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.35,
        color: primary,
      ),
      // Corps
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: primary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: secondary,
      ),
      // Étiquettes / boutons
      labelLarge: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: primary,
        letterSpacing: 0.2,
      ),
      labelMedium: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        height: 1.2,
        color: secondary,
        letterSpacing: 0.3,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: secondary,
        letterSpacing: 0.5,
      ),
    );
  }

  static TextTheme get light =>
      textThemeFor(AppColors.textPrimary, AppColors.textSecondary);

  static TextTheme get dark =>
      textThemeFor(AppColors.textOnDark, AppColors.textSecondaryDark);
}
