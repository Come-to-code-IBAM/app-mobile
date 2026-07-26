import '../../../data/models/ration_result.dart';

/// Accès local aux résultats de ration (table `local_ration`).
class RationsDao {
  Future<List<RationResult>> history() => throw UnimplementedError();
  Future<void> save(RationResult ration) => throw UnimplementedError();
}
