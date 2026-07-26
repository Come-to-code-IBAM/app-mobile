/// Événement de la file de synchronisation (miroir local de `outbox_event`).
enum SyncOperation { create, update, delete }

class SyncEvent {
  const SyncEvent({
    required this.eventUuid,
    required this.entity,
    required this.operation,
    required this.payload,
    required this.eventTime,
    this.attempts = 0,
  });

  final String eventUuid;
  final String entity;
  final SyncOperation operation;
  final Map<String, dynamic> payload;
  final DateTime eventTime;
  final int attempts;
}
