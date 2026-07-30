import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/models/animal.dart';
import '../app_database.dart';

/// Accès local aux animaux enrôlés (table `local_animal`).
class AnimalsDao {
  AnimalsDao(this._database);

  final AppDatabase _database;

  Future<List<Animal>> all() async {
    final db = await _database.database;
    final rows = await db.query('local_animal', orderBy: 'updated_at DESC');
    debugPrint('[AnimalsDao] all rows=${rows.length}');
    return rows.map(_fromRow).toList();
  }

  Future<Animal?> byLocalUuid(String localUuid) async {
    final db = await _database.database;
    final rows = await db.query(
      'local_animal',
      where: 'local_uuid = ?',
      whereArgs: [localUuid],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return _fromRow(rows.first);
  }

  Future<void> upsert(Animal animal) async {
    debugPrint('[AnimalsDao] upsert local_uuid=${animal.localUuid}');
    final db = await _database.database;
    await db.insert(
      'local_animal',
      {
        'local_uuid':       animal.localUuid,
        'public_id':        animal.publicId,
        'owner_name':       animal.ownerName,
        'owner_phone':      animal.ownerPhone,
        'signature_blob':   animal.signatureBlob != null
                              ? Uint8List.fromList(animal.signatureBlob!)
                              : null,
        'signature_ref':    animal.signatureRef,
        'species':          animal.species.name,
        'breed':            animal.breed,
        'age_estimate':     animal.ageEstimate,
        'distinctive_sign': animal.distinctiveSign,
        'tag_code':         animal.tagCode,
        'status':           animal.status.name,
        'village':          animal.village,
        'witness_name':     animal.witnessName,
        'witness_phone':    animal.witnessPhone,
        'is_dirty':         animal.syncPending ? 1 : 0,
        'sync_status':      animal.syncStatus,
        'updated_at':       animal.updatedAt.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> markStolen(String localUuid) async {
    debugPrint('[AnimalsDao] markStolen local_uuid=$localUuid');
    final db = await _database.database;
    await db.update(
      'local_animal',
      {
        'status':      AnimalStatus.stolen.name,
        'is_dirty':    1,
        'sync_status': 'pending',
        'updated_at':  DateTime.now().toIso8601String(),
      },
      where: 'local_uuid = ?',
      whereArgs: [localUuid],
    );
  }

  /// Retourne tous les animaux ayant une signature locale (pour la vérification hors ligne).
  Future<List<Animal>> withSignature() async {
    final db = await _database.database;
    final rows = await db.query(
      'local_animal',
      where: 'signature_blob IS NOT NULL',
    );
    return rows.map(_fromRow).toList();
  }

  Animal _fromRow(Map<String, Object?> row) {
    final blob = row['signature_blob'];
    return Animal(
      localUuid:       row['local_uuid'] as String,
      publicId:        row['public_id'] as String?,
      ownerName:       row['owner_name'] as String,
      ownerPhone:      row['owner_phone'] as String,
      signatureBlob:   blob != null ? List<int>.from(blob as List) : null,
      signatureRef:    row['signature_ref'] as String?,
      species:         AnimalSpecies.values.firstWhere(
                         (e) => e.name == row['species'],
                         orElse: () => AnimalSpecies.bovin,
                       ),
      breed:           row['breed'] as String?,
      ageEstimate:     row['age_estimate'] as int?,
      distinctiveSign: row['distinctive_sign'] as String?,
      tagCode:         row['tag_code'] as String?,
      status:          AnimalStatus.values.firstWhere(
                         (e) => e.name == row['status'],
                         orElse: () => AnimalStatus.active,
                       ),
      village:         row['village'] as String?,
      witnessName:     row['witness_name'] as String?,
      witnessPhone:    row['witness_phone'] as String?,
      syncPending:     (row['is_dirty'] as int?) == 1,
      syncStatus:      (row['sync_status'] as String?) ?? 'pending',
      updatedAt:       DateTime.parse(row['updated_at'] as String),
    );
  }
}