import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

/// Base SQLite locale (mode hors ligne).
///
/// Tout s'écrit en local d'abord ; la synchronisation vers le serveur est
/// opportuniste. Le schéma reflète les tables `local_*` et la file `outbox`.
class AppDatabase {
  Database? _db;

  static const String fileName = 'carnet_troupeau.db';
  static const int version = 2;

  /// Ouvre (et crée au besoin) la base ; réutilise l'instance ouverte.
  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    await open();
    return _db!;
  }

  Future<void> open() async {
    final databasesPath = await getDatabasesPath();
    final path = p.join(databasesPath, fileName);
    _db = await openDatabase(
      path,
      version: version,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
    );
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE local_ration(
        local_uuid TEXT PRIMARY KEY,
        public_id TEXT,
        herd_snapshot TEXT,
        available_feeds TEXT,
        mix_result TEXT,
        total_cost REAL,
        sync_pending INTEGER DEFAULT 1,
        created_at TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE outbox_event(
        event_uuid TEXT PRIMARY KEY,
        entity TEXT NOT NULL,
        operation TEXT NOT NULL,
        payload TEXT,
        event_time TEXT,
        attempts INTEGER DEFAULT 0
      )
    ''');
  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS local_ration(
          local_uuid TEXT PRIMARY KEY,
          public_id TEXT,
          herd_snapshot TEXT,
          available_feeds TEXT,
          mix_result TEXT,
          total_cost REAL,
          sync_pending INTEGER DEFAULT 1,
          created_at TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS outbox_event(
          event_uuid TEXT PRIMARY KEY,
          entity TEXT NOT NULL,
          operation TEXT NOT NULL,
          payload TEXT,
          event_time TEXT,
          attempts INTEGER DEFAULT 0
        )
      ''');
    }
  }

  Future<void> close() async {
    await _db?.close();
    _db = null;
  }
}
