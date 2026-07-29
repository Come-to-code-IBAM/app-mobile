/// Client HTTP vers l'API serveur (NestJS).
///
/// Seul point de contact réseau de l'app. Gère l'authentification et relaie
/// les lots de synchronisation. N'est jamais appelé de façon bloquante depuis
/// l'interface : la couche repository décide quand synchroniser.
class ApiClient {
  Future<bool> ping() async => true;

  Future<Map<String, dynamic>> post(String path, Object body) async {
    // Stub réseau : retourne un succès local sans vrai appel HTTP.
    return {'success': true};
  }

  Future<Map<String, dynamic>> get(String path) async {
    // Stub réseau : retourne un résultat vide pour /sync/pull.
    return {'items': <Map<String, dynamic>>[]};
  }
}
