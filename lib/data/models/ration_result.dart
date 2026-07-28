import 'dart:convert';

/// Résultat d'un calcul de ration (miroir local de `local_ration`).
class RationResult {
  const RationResult({
    required this.localUuid,
    this.publicId,
    required this.herdSnapshot,
    required this.availableFeeds,
    required this.mixResult,
    required this.totalCost,
    required this.createdAt,
    this.syncPending = true,
  });

  final String localUuid;
  final String? publicId;
  final Map<String, dynamic> herdSnapshot;
  final List<Map<String, dynamic>> availableFeeds;
  final List<Map<String, dynamic>> mixResult;
  final double totalCost;
  final DateTime createdAt;
  final bool syncPending;

  Map<String, dynamic> toJson() => {
        'local_uuid': localUuid,
        'public_id': publicId,
        'herd_snapshot': herdSnapshot,
        'available_feeds': availableFeeds,
        'mix_result': mixResult,
        'total_cost': totalCost,
        'created_at': createdAt.toIso8601String(),
        'sync_pending': syncPending,
      };

  factory RationResult.fromJson(Map<String, dynamic> json) {
    return RationResult(
      localUuid: json['local_uuid'] as String,
      publicId: json['public_id'] as String?,
      herdSnapshot: Map<String, dynamic>.from(json['herd_snapshot'] as Map? ?? {}),
      availableFeeds: json['available_feeds'] != null
          ? List<Map<String, dynamic>>.from(
              (json['available_feeds'] as List).map((item) => Map<String, dynamic>.from(item as Map)))
          : <Map<String, dynamic>>[],
      mixResult: json['mix_result'] != null
          ? List<Map<String, dynamic>>.from(
              (json['mix_result'] as List).map((item) => Map<String, dynamic>.from(item as Map)))
          : <Map<String, dynamic>>[],
      totalCost: (json['total_cost'] as num?)?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(json['created_at'] as String),
      syncPending: json['sync_pending'] == true || json['sync_pending'] == 1,
    );
  }

  String toJsonString() => jsonEncode(toJson());

  factory RationResult.fromJsonString(String source) =>
      RationResult.fromJson(jsonDecode(source) as Map<String, dynamic>);
}
