import '../models/ration_result.dart';

/// Logique métier de la ration : calcul (solveur) et historique.
class RationRepository {
  Future<RationResult> compute({
    required Map<String, dynamic> herd,
    required List<Map<String, dynamic>> feeds,
  }) => throw UnimplementedError();

  Future<List<RationResult>> history() => throw UnimplementedError();
}
