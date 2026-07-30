import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

/// Base SQLite locale (mode hors ligne).
///
/// Tout s'écrit en local d'abord ; la synchronisation vers le serveur est
/// opportuniste. Le schéma reflète les tables `local_*` et la file `outbox`.
class AppDatabase {
  Database? _db;

  static const String fileName = 'carnet_troupeau.db';
  static const int version = 3;

  Future<Database> get database async {
    if (_db != null) return _db!;
    await open();
    return _db!;
  }

  Future<void> open() async {
    final databasesPath = await getDatabasesPath();
    final path = p.join(databasesPath, fileName);
    _db = await openDatabase(
      path,
      version: version,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onOpen: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE local_animal (
        local_uuid       TEXT PRIMARY KEY,
        public_id        TEXT UNIQUE,
        owner_name       TEXT NOT NULL,
        owner_phone      TEXT NOT NULL,
        signature_blob   BLOB,
        signature_ref    TEXT,
        species          TEXT NOT NULL DEFAULT 'bovin',
        breed            TEXT,
        age_estimate     INTEGER,
        distinctive_sign TEXT,
        tag_code         TEXT,
        status           TEXT NOT NULL DEFAULT 'active',
        village          TEXT,
        witness_name     TEXT,
        witness_phone    TEXT,
        is_dirty         INTEGER NOT NULL DEFAULT 1,
        sync_status      TEXT NOT NULL DEFAULT 'pending',
        updated_at       TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE local_theft_report (
        local_uuid   TEXT PRIMARY KEY,
        public_id    TEXT UNIQUE,
        animal_uuid  TEXT NOT NULL,
        location     TEXT,
        circumstances TEXT,
        status       TEXT NOT NULL DEFAULT 'open',
        report_date  TEXT NOT NULL,
        is_dirty     INTEGER NOT NULL DEFAULT 1,
        sync_status  TEXT NOT NULL DEFAULT 'pending',
        updated_at   TEXT NOT NULL,
        FOREIGN KEY (animal_uuid) REFERENCES local_animal(local_uuid) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE local_ration (
        local_uuid      TEXT PRIMARY KEY,
        public_id       TEXT,
        herd_snapshot   TEXT,
        available_feeds TEXT,
        mix_result      TEXT,
        total_cost      REAL,
        sync_pending    INTEGER DEFAULT 1,
        created_at      TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE outbox_event (
        event_uuid  TEXT PRIMARY KEY,
        entity      TEXT NOT NULL,
        operation   TEXT NOT NULL,
        payload     TEXT,
        event_time  TEXT,
        attempts    INTEGER DEFAULT 0
      )
    ''');

    await db.execute('CREATE INDEX idx_local_animal_status ON local_animal(status)');
    await db.execute('CREATE INDEX idx_local_animal_dirty  ON local_animal(is_dirty)');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      // v1/v2 n'avaient pas local_animal ni local_theft_report.
      await db.execute('''
        CREATE TABLE IF NOT EXISTS local_animal (
          local_uuid       TEXT PRIMARY KEY,
          public_id        TEXT UNIQUE,
          owner_name       TEXT NOT NULL,
          owner_phone      TEXT NOT NULL,
          signature_blob   BLOB,
          signature_ref    TEXT,
          species          TEXT NOT NULL DEFAULT 'bovin',
          breed            TEXT,
          age_estimate     INTEGER,
          distinctive_sign TEXT,
          tag_code         TEXT,
          status           TEXT NOT NULL DEFAULT 'active',
          village          TEXT,
          witness_name     TEXT,
          witness_phone    TEXT,
          is_dirty         INTEGER NOT NULL DEFAULT 1,
          sync_status      TEXT NOT NULL DEFAULT 'pending',
          updated_at       TEXT NOT NULL
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS local_theft_report (
          local_uuid    TEXT PRIMARY KEY,
          public_id     TEXT UNIQUE,
          animal_uuid   TEXT NOT NULL,
          location      TEXT,
          circumstances TEXT,
          status        TEXT NOT NULL DEFAULT 'open',
          report_date   TEXT NOT NULL,
          is_dirty      INTEGER NOT NULL DEFAULT 1,
          sync_status   TEXT NOT NULL DEFAULT 'pending',
          updated_at    TEXT NOT NULL,
          FOREIGN KEY (animal_uuid) REFERENCES local_animal(local_uuid) ON DELETE CASCADE
        )
      ''');

      await db.execute('CREATE INDEX IF NOT EXISTS idx_local_animal_status ON local_animal(status)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_local_animal_dirty  ON local_animal(is_dirty)');
    }
  }

  Future<void> close() async {
    await _db?.close();
    _db = null;
  }
}