/// Zone cultivée déclarée (miroir local de `local_zone`).
class CultivatedZone {
  const CultivatedZone({
    required this.localUuid,
    this.publicId,
    required this.polygon,
    this.cropType,
    this.harvestPeriod,
    this.syncPending = true,
  });

  final String localUuid;
  final String? publicId;

  /// Contour GeoJSON (liste de points).
  final Map<String, dynamic> polygon;
  final String? cropType;
  final String? harvestPeriod;
  final bool syncPending;
}
