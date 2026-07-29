import 'package:sqflite/sqflite.dart';

import '../../../data/models/sync_event.dart';
import '../app_database.dart';

/// File d'attente de synchronisation (table `outbox_event`).
///
/// Chaque écriture métier y ajoute un événement idempotent (uuid client),
/// poussé vers le serveur dès qu'une connexion est disponible.
class SyncDao {
  SyncDao(this._database);

  final AppDatabase _database;

  Future<void> enqueue(SyncEvent event) async {
    final db = await _database.database;
    await db.insert(
      'outbox_event',
      {
        'event_uuid': event.eventUuid,
        'entity': event.entity,
        'operation': event.operation.name,
        'payload': event.payload.toString(),
        'event_time': event.eventTime.toIso8601String(),
        'attempts': event.attempts,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SyncEvent>> pending() async {
    final db = await _database.database;
    final rows = await db.query('outbox_event', orderBy: 'event_time ASC');
    return rows.map((row) => _fromRow(row)).toList();
  }

  Future<void> markSent(String eventUuid) async {
    final db = await _database.database;
    await db.delete('outbox_event', where: 'event_uuid = ?', whereArgs: [eventUuid]);
  }

  Future<int> pendingCount() async {
    final db = await _database.database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM outbox_event');
    return (result.first['count'] as int?) ?? 0;
  }

  SyncEvent _fromRow(Map<String, Object?> row) {
    return SyncEvent(
      eventUuid: row['event_uuid'] as String,
      entity: row['entity'] as String,
      operation: SyncOperation.values.firstWhere(
        (value) => value.name == row['operation'],
        orElse: () => SyncOperation.create,
      ),
      payload: const {},
      eventTime: DateTime.parse(row['event_time'] as String),
      attempts: (row['attempts'] as int?) ?? 0,
    );
  }
}
