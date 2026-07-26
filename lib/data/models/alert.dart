/// Alerte émise (vol ou conflit) — miroir local de `local_alert`.
///
/// Pour le conflit, `plan` indique le chemin de la cascade utilisé :
/// A = SMS direct du téléphone, B = via serveur (internet), C = via serveur (SMS).
enum AlertType { theft, conflict }

enum AlertPlan { a, b, c }

enum AlertDelivery { internet, sms, call }

class Alert {
  const Alert({
    required this.localUuid,
    required this.type,
    this.relatedUuid,
    this.location,
    this.plan,
    this.delivery = AlertDelivery.sms,
    this.syncPending = true,
    required this.sentAt,
  });

  final String localUuid;
  final AlertType type;
  final String? relatedUuid;
  final String? location;
  final AlertPlan? plan;
  final AlertDelivery delivery;
  final bool syncPending;
  final DateTime sentAt;
}
