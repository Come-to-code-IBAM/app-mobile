/// Résultat d'un calcul de ration (miroir local de `local_ration`).
class RationResult {
  const RationResult({
    required this.localUuid,
    this.publicId,
    required this.herdSnapshot,
    required this.availableFeeds,
    required this.mixResult,
    required this.totalCost,
    this.syncPending = true,
  });

  final String localUuid;
  final String? publicId;
  final Map<String, dynamic> herdSnapshot;
  final List<Map<String, dynamic>> availableFeeds;
  final List<Map<String, dynamic>> mixResult;
  final double totalCost;
  final bool syncPending;
}
