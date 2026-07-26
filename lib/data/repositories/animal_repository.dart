import '../models/animal.dart';

/// Logique métier des animaux : enrôlement, vérification, signalement de vol.
/// Écrit en local d'abord, met en file la synchronisation.
class AnimalRepository {
  Future<List<Animal>> list() => throw UnimplementedError();
  Future<void> enroll(Animal animal) => throw UnimplementedError();
  Future<Animal?> verifyBySignature(List<int> muzzleImage) =>
      throw UnimplementedError();
  Future<void> reportStolen(String localUuid) => throw UnimplementedError();
}
