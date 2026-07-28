import '../../../data/models/cultivated_zone.dart';
import '../app_database.dart';

/// Accès local aux zones cultivées et contacts en cache (tables `local_zone`,
/// `local_cached_contact`).
class ZonesDao {
  ZonesDao(this._database);

  final AppDatabase _database;

  Future<List<CultivatedZone>> all() async => <CultivatedZone>[];
  Future<void> upsert(CultivatedZone zone) async {}
  Future<String?> cachedContactForZone(String zonePublicId) async => null;
}
