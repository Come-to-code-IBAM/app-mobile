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
import 'package:sqflite/sqflite.dart' as sqflite;


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

  /// Construit et câble toutes les dépendances.
  static Future<AppServices> create() async {
    final database = AppDatabase();
    await database.open();

    final api = ApiClient();
    final animalsDao = AnimalsDao(database);
    final rationsDao = RationsDao(database);
    final zonesDao = ZonesDao(database);
    final syncDao = SyncDao(database);

    final animalRepository = AnimalRepository(
      animalsDao: animalsDao,
      syncDao:    syncDao,
      apiClient:  api,
    );
    final rationRepository = RationRepository(
      rationsDao: rationsDao,
      syncDao: syncDao,
      apiClient: api,
    );
    final zoneRepository = ZoneRepository();
    final syncService = SyncService(syncDao: syncDao, apiClient: api);

    return AppServices._(
      api: api,
      database: database,
      animalsDao: animalsDao,
      rationsDao: rationsDao,
      zonesDao: zonesDao,
      syncDao: syncDao,
      animalRepository: animalRepository,
      rationRepository: rationRepository,
      zoneRepository: zoneRepository,
      syncService: syncService,
    );
  }

  /// Déclenche une synchronisation opportuniste avec le serveur.
  Future<void> sync() async {
    await syncService.syncNow();
  }
}
