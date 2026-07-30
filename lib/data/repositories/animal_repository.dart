import 'dart:convert';

import '../models/animal.dart';
import '../models/sync_event.dart';
import '../../core/database/daos/animals_dao.dart';
import '../../core/database/daos/sync_dao.dart';
import '../../core/network/api_client.dart';
import '../../core/config/constants.dart';

/// Logique métier des animaux : enrôlement, vérification, signalement de vol.
/// Écrit en local d'abord, met en file la synchronisation.
class AnimalRepository {
  AnimalRepository({
    required this.animalsDao,
    required this.syncDao,
    required this.apiClient,
  });

  final AnimalsDao animalsDao;
  final SyncDao syncDao;
  final ApiClient apiClient;

  Future<List<Animal>> list() => animalsDao.all();

  /// Enrôle un animal : écriture locale puis mise en file d'attente.
  Future<void> enroll(Animal animal) async {
    await animalsDao.upsert(animal);
    await syncDao.enqueue(SyncEvent(
      eventUuid: animal.localUuid,
      entity:    AppConstants.entityAnimal,
      operation: SyncOperation.create,
      payload:   _toPayload(animal),
      eventTime: DateTime.now(),
    ));
  }

  /// Signale un vol : passe le statut local à `stolen` et met en file.
  Future<void> reportStolen(String localUuid) async {
    await animalsDao.markStolen(localUuid);
    await syncDao.enqueue(SyncEvent(
      eventUuid: '${localUuid}_stolen_${DateTime.now().millisecondsSinceEpoch}',
      entity:    AppConstants.entityAnimal,
      operation: SyncOperation.update,
      payload:   {'local_uuid': localUuid, 'status': AnimalStatus.stolen.name},
      eventTime: DateTime.now(),
    ));
  }

  /// Vérification par image du mufle.
  ///
  /// Cherche d'abord dans le cache local de signatures.
  /// Si rien en local et qu'on est en ligne, délègue au serveur.
  /// Sinon retourne [VerifyOutcome.pendingOnline].
  Future<VerifyResult> verifyByImage(List<int> imageBytes) async {
    final candidates = await animalsDao.withSignature();

    // Tentative serveur si en ligne.
    final online = await apiClient.ping();
    if (!online) {
      return const VerifyResult(outcome: VerifyOutcome.pendingOnline);
    }

    try {
      final base64Image = base64Encode(imageBytes);
      final candidatePayload = candidates
          .where((a) => a.signatureBlob != null)
          .map((a) => {
                'animal_public_id': a.publicId ?? a.localUuid,
                'embedding': a.signatureBlob,
              })
          .toList();

      final result = await apiClient.post('/animals/verify', {
        'muzzleImage': base64Image,
        'candidates': candidatePayload,
      });

      final status = result['status'] as String?;
      if (status == 'recognized' || status == 'stolen') {
        final animalId = result['animal']?['local_uuid'] as String?;
        Animal? animal;
        if (animalId != null) {
          animal = await animalsDao.byLocalUuid(animalId);
        }
        return VerifyResult(
          outcome: status == 'stolen'
              ? VerifyOutcome.stolen
              : VerifyOutcome.recognized,
          animal: animal,
        );
      }
      return const VerifyResult(outcome: VerifyOutcome.unknown);
    } catch (_) {
      return const VerifyResult(outcome: VerifyOutcome.unknown);
    }
  }

  Map<String, dynamic> _toPayload(Animal animal) => {
        'local_uuid':       animal.localUuid,
        'public_id':        animal.publicId,
        'owner_name':       animal.ownerName,
        'owner_phone':      animal.ownerPhone,
        'species':          animal.species.name,
        'breed':            animal.breed,
        'age_estimate':     animal.ageEstimate,
        'distinctive_sign': animal.distinctiveSign,
        'tag_code':         animal.tagCode,
        'status':           animal.status.name,
        'village':          animal.village,
        'witness_name':     animal.witnessName,
        'witness_phone':    animal.witnessPhone,
      };
}

/// Résultat d'une vérification biométrique.
enum VerifyOutcome { recognized, stolen, unknown, pendingOnline }

class VerifyResult {
  const VerifyResult({required this.outcome, this.animal});
  final VerifyOutcome outcome;
  final Animal? animal;
}