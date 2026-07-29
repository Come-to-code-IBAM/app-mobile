import 'package:flutter/material.dart';

import 'app.dart';
import 'core/app/app_scope.dart';
import 'core/app/app_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final services = await AppServices.create();

  runApp(
    AppScope(
      services: services,
      child: const App(),
    ),
  );
}
