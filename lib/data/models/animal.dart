/// Fiche animal du carnet numérique (miroir local de `local_animal`).
enum AnimalStatus { active, stolen, transferred, dead }

enum AnimalSpecies { bovin, ovin, caprin, asin, autre }

class Animal {
  Animal({
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
    this.witnessName,
    this.witnessPhone,
    this.signatureBlob,
    this.signatureRef,
    this.syncPending = true,
    this.syncStatus = 'pending',
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

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
  final String? witnessName;
  final String? witnessPhone;
  // Empreinte binaire du mufle (ORB), stockée en BLOB dans SQLite.
  final List<int>? signatureBlob;
  // Identifiant serveur de la signature, rempli après synchro réussie.
  final String? signatureRef;
  final bool syncPending;
  final String syncStatus; // pending | synced | conflict
  final DateTime updatedAt;

  Animal copyWith({
    String? publicId,
    AnimalStatus? status,
    String? signatureRef,
    bool? syncPending,
    String? syncStatus,
    List<int>? signatureBlob,
    DateTime? updatedAt,
  }) {
    return Animal(
      localUuid: localUuid,
      publicId: publicId ?? this.publicId,
      ownerName: ownerName,
      ownerPhone: ownerPhone,
      species: species,
      breed: breed,
      ageEstimate: ageEstimate,
      distinctiveSign: distinctiveSign,
      tagCode: tagCode,
      status: status ?? this.status,
      village: village,
      witnessName: witnessName,
      witnessPhone: witnessPhone,
      signatureBlob: signatureBlob ?? this.signatureBlob,
      signatureRef: signatureRef ?? this.signatureRef,
      syncPending: syncPending ?? this.syncPending,
      syncStatus: syncStatus ?? this.syncStatus,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}