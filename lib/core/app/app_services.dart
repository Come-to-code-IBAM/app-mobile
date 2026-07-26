import '../database/app_database.dart';
import '../database/daos/animals_dao.dart';
import '../database/daos/rations_dao.dart';
import '../database/daos/zones_dao.dart';
import '../database/daos/sync_dao.dart';
import '../network/api_client.dart';
import '../sync/sync_service.dart';
import '../../data/repositories/animal_repository.dart';
import '../../data/repositories/ration_repository.dart';
import '../../data/repositories/zone_repository.dart';

/// Point d'entrée des dépendances partagées de l'application.
///
/// Assemblé une seule fois au démarrage, puis exposé à l'arbre de widgets via
/// [AppScope]. Aucune logique ici : uniquement le câblage des dépendances.
class AppServices {
  AppServices._({
    required this.api,
    required this.database,
    required this.animalsDao,
    required this.rationsDao,
    required this.zonesDao,
    required this.syncDao,
    required this.animalRepository,
    required this.rationRepository,
    required this.zoneRepository,
    required this.syncService,
  });

  final ApiClient api;
  final AppDatabase database;

  final AnimalsDao animalsDao;
  final RationsDao rationsDao;
  final ZonesDao zonesDao;
  final SyncDao syncDao;

  final AnimalRepository animalRepository;
  final RationRepository rationRepository;
  final ZoneRepository zoneRepository;

  final SyncService syncService;

  /// Construit et câble toutes les dépendances. À implémenter.
  static Future<AppServices> create() {
    throw UnimplementedError();
  }

  /// Déclenche une synchronisation opportuniste avec le serveur.
  Future<void> sync() {
    throw UnimplementedError();
  }
}
