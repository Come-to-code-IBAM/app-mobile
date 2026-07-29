import 'dart:math' as math;
import 'package:flutter/foundation.dart';

import '../models/ration_result.dart';
import '../../core/database/daos/rations_dao.dart';
import '../../core/database/daos/sync_dao.dart';
import '../../core/network/api_client.dart';
import '../../data/models/sync_event.dart';
import '../../core/config/constants.dart';

/// Logique métier de la ration : calcul (solveur) et historique.
class RationRepository {
  RationRepository({
    RationsDao? rationsDao,
    SyncDao? syncDao,
    ApiClient? apiClient,
  })  : _rationsDao = rationsDao,
        _syncDao = syncDao,
        _apiClient = apiClient;

  final RationsDao? _rationsDao;
  final SyncDao? _syncDao;
  final ApiClient? _apiClient;

  Future<RationResult> compute({
    required Map<String, dynamic> herd,
    required List<Map<String, dynamic>> feeds,
  }) async {
    final selectedFeeds =
        feeds.where((feed) => feed['selected'] == true).toList();
    final totalAnimals = _sumHerd(herd);

    final mixResult = <Map<String, dynamic>>[];
    var totalCost = 0.0;
    for (final feed in selectedFeeds) {
      final price = (feed['pricePerKg'] as num?)?.toDouble() ?? 0.0;
      final quantity =
          _quantityForFeed(totalAnimals, feed['name'] as String? ?? '');
      totalCost += price * quantity;
      mixResult.add({
        'name': feed['name'],
        'quantityKg': quantity,
        'pricePerKg': price,
      });
    }

    final result = RationResult(
      localUuid: 'ration_${DateTime.now().microsecondsSinceEpoch}',
      herdSnapshot: herd,
      availableFeeds: selectedFeeds,
      mixResult: mixResult,
      totalCost: totalCost,
      createdAt: DateTime.now(),
    );

    if (_rationsDao == null || _syncDao == null || _apiClient == null) {
      throw StateError(
          'RationRepository requires all dependencies for compute.');
    }

    await _rationsDao!.save(result);
    await _syncDao!.enqueue(
      SyncEvent(
        eventUuid: result.localUuid,
        entity: AppConstants.entityRation,
        operation: SyncOperation.create,
        payload: {
          'local_uuid': result.localUuid,
          'herd_snapshot': result.herdSnapshot,
          'available_feeds': result.availableFeeds,
          'mix_result': result.mixResult,
          'total_cost': result.totalCost,
        },
        eventTime: DateTime.now(),
      ),
    );
    await _apiClient!.post('/sync/push', {
      'entity': AppConstants.entityRation,
      'payload': result.toString(),
    });

    return result;
  }

  Future<List<RationResult>> history() async =>
      _rationsDao?.history() ?? <RationResult>[];

  Future<void> saveResult(RationResult result) async {
    if (_rationsDao == null || _syncDao == null) {
      throw StateError(
          'RationRepository requires a RationsDao and SyncDao to save results.');
    }
    debugPrint(
        '[RationRepository] saveResult start local_uuid=${result.localUuid}');
    await _rationsDao!.save(result);
    debugPrint(
        '[RationRepository] saveResult saved local_uuid=${result.localUuid}');
    await _syncDao!.enqueue(
      SyncEvent(
        eventUuid: result.localUuid,
        entity: AppConstants.entityRation,
        operation: SyncOperation.create,
        payload: {
          'local_uuid': result.localUuid,
          'herd_snapshot': result.herdSnapshot,
          'available_feeds': result.availableFeeds,
          'mix_result': result.mixResult,
          'total_cost': result.totalCost,
        },
        eventTime: DateTime.now(),
      ),
    );
    debugPrint(
        '[RationRepository] saveResult queued sync local_uuid=${result.localUuid}');
  }

  int _sumHerd(Map<String, dynamic> herd) {
    return herd.values.fold<int>(0, (sum, value) {
      if (value is num) {
        return sum + value.toInt();
      }
      return sum;
    });
  }

  double _quantityForFeed(int totalAnimals, String feedName) {
    final base = totalAnimals * 0.8;
    switch (feedName) {
      case 'Tourteau de coton':
        return math.max(1.0, base * 0.15);
      case 'Son de maïs':
        return math.max(1.0, base * 0.25);
      case 'Fanes de niébé':
        return math.max(1.0, base * 0.2);
      default:
        return math.max(1.0, base * 0.1);
    }
  }
}
