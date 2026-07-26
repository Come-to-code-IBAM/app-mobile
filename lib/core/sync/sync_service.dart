/// Orchestration de la synchronisation hors ligne <-> serveur.
///
/// Pousse la file `outbox` via /sync/push, récupère les changements distants
/// via /sync/pull, et applique la stratégie de résolution de conflits (le
/// serveur reste l'autorité finale).
class SyncService {
  Future<void> pushPending() => throw UnimplementedError();
  Future<void> pullChanges() => throw UnimplementedError();
  Future<void> syncNow() => throw UnimplementedError();
}
