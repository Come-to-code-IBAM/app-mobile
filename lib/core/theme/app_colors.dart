import 'package:flutter/material.dart';

/// Palette de l'application, dérivée de l'affiche « Come to Code » du C2I :
/// bleu marine profond (institutionnel, confiance) + vert agro (le terrain).
///
/// Les tons sont pensés pour le terrain : fort contraste, lisibilité en plein
/// soleil, et sémantique claire des états (actif, volé, alerte, hors ligne).
abstract final class AppColors {
  const AppColors._();

  // Marque — bleu marine (structure, en-têtes, actions primaires)
  static const Color navy = Color(0xFF0C2C4C);
  static const Color navyDark = Color(0xFF07203A);
  static const Color navyLight = Color(0xFF1B4A78);

  // Marque — vert agro (accent, validations, éléments « vivants »)
  static const Color green = Color(0xFF3B6D11);
  static const Color greenBright = Color(0xFF5F9A1E);
  static const Color greenLight = Color(0xFFEAF3DE);

  // Surfaces claires
  static const Color background = Color(0xFFF7F7F3);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFF1EFE8);

  // Surfaces sombres (mode nuit / usage nocturne au pâturage)
  static const Color backgroundDark = Color(0xFF0B1620);
  static const Color surfaceDark = Color(0xFF13212E);
  static const Color surfaceAltDark = Color(0xFF1B2E3E);

  // Texte
  static const Color textPrimary = Color(0xFF16211C);
  static const Color textSecondary = Color(0xFF5A6560);
  static const Color textOnDark = Color(0xFFF2F5F1);
  static const Color textSecondaryDark = Color(0xFFA8B4AD);

  // Bordures
  static const Color border = Color(0xFFDBD9CF);
  static const Color borderDark = Color(0xFF2A3C4C);

  // États sémantiques
  static const Color statusActive = Color(0xFF3B6D11); // animal actif / sain
  static const Color statusStolen = Color(0xFFA32D2D); // signalé volé (rouge)
  static const Color statusAlert = Color(0xFFBA7517); // alerte / conflit (ambre)
  static const Color statusInfo = Color(0xFF185FA5); // information
  static const Color offline = Color(0xFF888780); // hors ligne / en attente

  static const Color danger = Color(0xFFA32D2D);
  static const Color dangerLight = Color(0xFFFCEBEB);
  static const Color warning = Color(0xFFBA7517);
  static const Color warningLight = Color(0xFFFAEEDA);
  static const Color success = Color(0xFF3B6D11);
  static const Color successLight = Color(0xFFEAF3DE);
}
