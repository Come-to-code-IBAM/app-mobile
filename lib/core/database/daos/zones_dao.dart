import '../../../data/models/cultivated_zone.dart';

/// Accès local aux zones cultivées et contacts en cache (tables `local_zone`,
/// `local_cached_contact`).
class ZonesDao {
  Future<List<CultivatedZone>> all() => throw UnimplementedError();
  Future<void> upsert(CultivatedZone zone) => throw UnimplementedError();
  Future<String?> cachedContactForZone(String zonePublicId) =>
      throw UnimplementedError();
}
