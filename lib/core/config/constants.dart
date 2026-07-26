/// Constantes globales de l'application.
abstract final class AppConstants {
  const AppConstants._();

  static const String appName = 'Carnet numérique du troupeau';

  /// API serveur (NestJS). En dev sur émulateur Android : 10.0.2.2.
  static const String defaultApiHost = '10.0.2.2';
  static const int apiPort = 3000;
  static const String apiPrefix = '/api';

  /// Rayon (km) du cache des contacts d'agriculteurs (règle du plan A).
  /// Valeur de repli ; la valeur effective vient du serveur (platform_setting).
  static const double contactCacheRadiusKm = 5;

  /// Distance (m) de déclenchement de l'alerte de conflit à l'approche
  /// d'une zone cultivée.
  static const int conflictAlertDistanceM = 500;

  /// Clés d'entités pour la file de synchronisation (outbox).
  static const String entityAnimal = 'animal';
  static const String entityRation = 'ration';
  static const String entityZone = 'zone';
  static const String entityTrack = 'track';
  static const String entityTheftReport = 'theft_report';
  static const String entityAlert = 'alert';
}
