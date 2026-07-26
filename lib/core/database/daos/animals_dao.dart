import '../../../data/models/animal.dart';

/// Accès local aux animaux enrôlés (table `local_animal`).
class AnimalsDao {
  Future<List<Animal>> all() => throw UnimplementedError();
  Future<Animal?> byLocalUuid(String localUuid) => throw UnimplementedError();
  Future<void> upsert(Animal animal) => throw UnimplementedError();
  Future<void> markStolen(String localUuid) => throw UnimplementedError();
}
