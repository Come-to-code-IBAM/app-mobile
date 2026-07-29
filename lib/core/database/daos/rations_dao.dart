import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/models/ration_result.dart';
import '../app_database.dart';

/// Accès local aux résultats de ration (table `local_ration`).
class RationsDao {
  RationsDao(this._database);

  final AppDatabase _database;

  Future<List<RationResult>> history() async {
    final db = await _database.database;
    final rows = await db.query(
      'local_ration',
      orderBy: 'created_at DESC',
    );
    debugPrint('[RationsDao] history rows=${rows.length}');
    return rows.map((row) => _fromRow(row)).toList();
  }

  Future<void> save(RationResult ration) async {
    debugPrint('[RationsDao] save local_uuid=${ration.localUuid}');
    final db = await _database.database;
    final createdAt = DateTime.now().toIso8601String();
    await db.insert(
      'local_ration',
      {
        'local_uuid': ration.localUuid,
        'public_id': ration.publicId,
        'herd_snapshot': jsonEncode(ration.herdSnapshot),
        'available_feeds': jsonEncode(ration.availableFeeds),
        'mix_result': jsonEncode(ration.mixResult),
        'total_cost': ration.totalCost,
        'sync_pending': ration.syncPending ? 1 : 0,
        'created_at': ration.createdAt.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    final countResult = await db.rawQuery('SELECT COUNT(*) AS count FROM local_ration');
    final rowCount = (countResult.first['count'] as int?) ?? 0;
    debugPrint('[RationsDao] local_ration count=$rowCount');
    debugPrint('[RationsDao] save completed local_uuid=${ration.localUuid}');
  }

  RationResult _fromRow(Map<String, Object?> row) {
    final herdSnapshotText = row['herd_snapshot'] as String?;
    final availableFeedsText = row['available_feeds'] as String?;
    final mixResultText = row['mix_result'] as String?;

    return RationResult(
      localUuid: row['local_uuid'] as String,
      publicId: row['public_id'] as String?,
      herdSnapshot: herdSnapshotText != null
          ? Map<String, dynamic>.from(_parseJsonOrDartMap(herdSnapshotText))
          : <String, dynamic>{},
      availableFeeds: availableFeedsText != null
          ? List<Map<String, dynamic>>.from(
              (_parseJsonOrDartList(availableFeedsText) as List)
                  .map((item) => Map<String, dynamic>.from(item as Map)))
          : <Map<String, dynamic>>[],
      mixResult: mixResultText != null
          ? List<Map<String, dynamic>>.from(
              (_parseJsonOrDartList(mixResultText) as List)
                  .map((item) => Map<String, dynamic>.from(item as Map)))
          : <Map<String, dynamic>>[],
      totalCost: (row['total_cost'] as num?)?.toDouble() ?? 0.0,
      createdAt: row['created_at'] != null
          ? DateTime.parse(row['created_at'] as String)
          : DateTime.now(),
      syncPending: (row['sync_pending'] as int?) == 1,
    );
  }

  dynamic _parseJsonOrDartValue(String value) {
    try {
      return jsonDecode(value);
    } on FormatException {
      final normalized = _normalizeDartToJson(value);
      return jsonDecode(normalized);
    }
  }

  Map<String, dynamic> _parseJsonOrDartMap(String value) {
    final raw = _parseJsonOrDartValue(value);
    return raw is Map<String, dynamic>
        ? raw
        : Map<String, dynamic>.from(raw as Map);
  }

  List<dynamic> _parseJsonOrDartList(String value) {
    final raw = _parseJsonOrDartValue(value);
    return raw is List ? raw : List<dynamic>.from(raw as List);
  }

  String _normalizeDartToJson(String value) {
    var normalized = value.replaceAll("'", '"');
    normalized = normalized.replaceAllMapped(
      RegExp(r'([a-zA-Z0-9_]+)\s*:'),
      (match) => '"${match[1]}":',
    );
    normalized = normalized.replaceAllMapped(
      RegExp(r':\s*([^"\[{\]\},][^,\}\]]*)'),
      (match) {
        final content = match[1]!.trim();
        if (content == 'true' || content == 'false' || content == 'null' || double.tryParse(content) != null) {
          return ': $content';
        }
        if (content.startsWith('"') || content.startsWith('[') || content.startsWith('{')) {
          return ': $content';
        }
        final escaped = content.replaceAll('"', '\\"');
        return ': "${escaped}"';
      },
    );
    return normalized;
  }
}
