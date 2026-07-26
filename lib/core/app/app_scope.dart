import 'package:flutter/widgets.dart';

import 'app_services.dart';

/// Expose [AppServices] à l'arbre de widgets.
///
/// Les écrans y accèdent via `AppScope.of(context)`. Choix volontaire de rester
/// sur un [InheritedWidget] simple plutôt qu'un gestionnaire d'état lourd :
/// l'app est modeste et cette approche reste lisible.
class AppScope extends InheritedWidget {
  const AppScope({
    super.key,
    required this.services,
    required super.child,
  });

  final AppServices services;

  static AppServices of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope introuvable dans l\'arbre de widgets');
    return scope!.services;
  }

  @override
  bool updateShouldNotify(AppScope oldWidget) =>
      services != oldWidget.services;
}
