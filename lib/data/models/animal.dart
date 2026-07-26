/// Fiche animal du carnet numérique (miroir local de `local_animal`).
enum AnimalStatus { active, stolen, transferred, dead }

enum AnimalSpecies { bovin, ovin, caprin, asin, autre }

class Animal {
  const Animal({
    required this.localUuid,
    this.publicId,
    required this.ownerName,
    required this.ownerPhone,
    required this.species,
    this.breed,
    this.ageEstimate,
    this.distinctiveSign,
    this.tagCode,
    this.status = AnimalStatus.active,
    this.village,
    this.syncPending = true,
  });

  final String localUuid;
  final String? publicId;
  final String ownerName;
  final String ownerPhone;
  final AnimalSpecies species;
  final String? breed;
  final int? ageEstimate;
  final String? distinctiveSign;
  final String? tagCode;
  final AnimalStatus status;
  final String? village;
  final bool syncPending;
}
