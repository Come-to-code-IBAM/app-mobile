import 'package:flutter/material.dart';

import '../../app.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/section_header.dart';

/// Première page : marque de l'app, puis routage vers le shell.
///
/// La logique de démarrage (chargement des services, identité locale) reste à
/// implémenter — ici seul le rendu visuel est en place.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Démarrage temporaire : bascule vers l'accueil après un court instant.
    // À remplacer par le bootstrap réel des services.
    Future<void>.delayed(const Duration(milliseconds: 900), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(App.routeHome);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BrandMark(compact: true),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Carnet numérique du troupeau',
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Anti-vol · Ration · Transhumance',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.greenBright,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            const SizedBox(
              width: 26,
              height: 26,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation(AppColors.greenBright),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
