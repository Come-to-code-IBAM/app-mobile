import '../../../data/models/animal.dart';
import '../app_database.dart';

/// Accès local aux animaux enrôlés (table `local_animal`).
class AnimalsDao {
  AnimalsDao(this._database);

  final AppDatabase _database;

  Future<List<Animal>> all() async => <Animal>[];
  Future<Animal?> byLocalUuid(String localUuid) async => null;
  Future<void> upsert(Animal animal) async {}
  Future<void> markStolen(String localUuid) async {}
}
