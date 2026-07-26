import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/section_header.dart';

/// Premier lancement : créer/associer le profil de l'utilisateur.
/// Gabarit visuel — le flux d'identité reste à implémenter.
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.xl),
              const BrandMark(),
              const Spacer(),
              const SectionHeader(
                eyebrow: 'Bienvenue',
                title: 'Configurons votre carnet',
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Renseignez votre nom et votre village pour commencer. '
                'Tout fonctionne ensuite hors ligne.',
                style: theme.textTheme.bodyLarge,
              ),
              const Spacer(),
              FilledButton(
                onPressed: () {},
                child: const Text('Commencer'),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}
