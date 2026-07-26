import 'package:flutter/widgets.dart';

/// Échelle d'espacement (base 4). À utiliser partout plutôt que des valeurs
/// magiques, pour un rythme visuel cohérent.
abstract final class AppSpacing {
  const AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  static const EdgeInsets screen = EdgeInsets.all(md);
  static const EdgeInsets screenH = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets card = EdgeInsets.all(md);
}

/// Rayons de coin. Généreux, pour une interface accueillante et non technique.
abstract final class AppRadius {
  const AppRadius._();

  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double pill = 999;

  static const Radius rSm = Radius.circular(sm);
  static const Radius rMd = Radius.circular(md);
  static const Radius rLg = Radius.circular(lg);

  static const BorderRadius card = BorderRadius.all(rLg);
  static const BorderRadius button = BorderRadius.all(rMd);
  static const BorderRadius field = BorderRadius.all(rMd);
}
