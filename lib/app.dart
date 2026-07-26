import 'package:flutter/material.dart';

import 'core/config/constants.dart';
import 'core/theme/app_theme.dart';
import 'features/shell/home_shell.dart';
import 'features/splash/splash_screen.dart';

/// Racine de l'application.
///
/// Le thème (clair/sombre) est appliqué ici ; le routage nommé conduit du
/// splash vers le shell principal à quatre onglets.
class App extends StatelessWidget {
  const App({super.key});

  static const String routeSplash = '/';
  static const String routeHome = '/home';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialRoute: routeSplash,
      routes: {
        routeSplash: (_) => const SplashScreen(),
        routeHome: (_) => const HomeShell(),
      },
    );
  }
}
