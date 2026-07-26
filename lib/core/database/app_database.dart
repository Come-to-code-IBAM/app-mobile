import 'package:sqflite/sqflite.dart';

/// Base SQLite locale (mode hors ligne).
///
/// Tout s'écrit en local d'abord ; la synchronisation vers le serveur est
/// opportuniste. Le schéma reflète les tables `local_*` et la file `outbox`.
class AppDatabase {
  Database? _db;

  static const String fileName = 'carnet_troupeau.db';
  static const int version = 1;

  /// Ouvre (et crée au besoin) la base ; réutilise l'instance ouverte.
  Future<Database> get database {
    throw UnimplementedError();
  }

  Future<void> open() {
    throw UnimplementedError();
  }

  Future<void> onCreate(Database db, int version) {
    throw UnimplementedError();
  }

  Future<void> close() {
    throw UnimplementedError();
  }
}
