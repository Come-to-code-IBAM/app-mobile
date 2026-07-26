import '../../../data/models/sync_event.dart';

/// File d'attente de synchronisation (table `outbox_event`).
///
/// Chaque écriture métier y ajoute un événement idempotent (uuid client),
/// poussé vers le serveur dès qu'une connexion est disponible.
class SyncDao {
  Future<void> enqueue(SyncEvent event) => throw UnimplementedError();
  Future<List<SyncEvent>> pending() => throw UnimplementedError();
  Future<void> markSent(String eventUuid) => throw UnimplementedError();
  Future<int> pendingCount() => throw UnimplementedError();
}
