/// Client HTTP vers l'API serveur (NestJS).
///
/// Seul point de contact réseau de l'app. Gère l'authentification et relaie
/// les lots de synchronisation. N'est jamais appelé de façon bloquante depuis
/// l'interface : la couche repository décide quand synchroniser.
class ApiClient {
  Future<bool> ping() => throw UnimplementedError();
  Future<Map<String, dynamic>> post(String path, Object body) =>
      throw UnimplementedError();
  Future<Map<String, dynamic>> get(String path) => throw UnimplementedError();
}
