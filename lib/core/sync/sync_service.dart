import '../database/daos/sync_dao.dart';
import '../network/api_client.dart';
import '../../data/models/sync_event.dart';

/// Orchestration de la synchronisation hors ligne <-> serveur.
///
/// Pousse la file `outbox` via /sync/push, récupère les changements distants
/// via /sync/pull, et applique la stratégie de résolution de conflits (le
/// serveur reste l'autorité finale).
class SyncService {
  SyncService({required SyncDao syncDao, required ApiClient apiClient})
      : _syncDao = syncDao,
        _apiClient = apiClient;

  final SyncDao _syncDao;
  final ApiClient _apiClient;

  Future<void> pushPending() async {
    final pending = await _syncDao.pending();
    for (final event in pending) {
      await _apiClient.post('/sync/push', {
        'entity': event.entity,
        'operation': event.operation.name,
        'payload': event.payload,
      });
      await _syncDao.markSent(event.eventUuid);
    }
  }

  Future<void> pullChanges() async {
    final response = await _apiClient.get('/sync/pull');
    if (response['items'] is List) {
      final items = response['items'] as List<dynamic>;
      for (final item in items) {
        if (item is Map<String, dynamic>) {
          await _syncDao.enqueue(
            SyncEvent(
              eventUuid: item['event_uuid']?.toString() ?? DateTime.now().toIso8601String(),
              entity: item['entity']?.toString() ?? 'ration',
              operation: SyncOperation.values.firstWhere(
                (value) => value.name == item['operation'],
                orElse: () => SyncOperation.create,
              ),
              payload: Map<String, dynamic>.from(item['payload'] ?? {}),
              eventTime: DateTime.now(),
            ),
          );
        }
      }
    }
  }

  Future<void> syncNow() async {
    await pushPending();
    await pullChanges();
  }
}
