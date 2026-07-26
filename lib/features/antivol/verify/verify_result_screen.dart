import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/detail_row.dart';

enum VerifyOutcome { recognized, stolen, unknown }

/// Résultat d'une vérification : reconnu / volé / inconnu.
class VerifyResultScreen extends StatelessWidget {
  const VerifyResultScreen({super.key, required this.outcome});

  final VerifyOutcome outcome;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (color, bg, icon, title, subtitle) = switch (outcome) {
      VerifyOutcome.recognized => (
          AppColors.success, AppColors.successLight, Icons.verified_outlined,
          'Animal reconnu', 'Propriétaire enregistré'),
      VerifyOutcome.stolen => (
          AppColors.danger, AppColors.dangerLight, Icons.gpp_bad_outlined,
          'Signalé volé', 'Cet animal a été déclaré volé'),
      VerifyOutcome.unknown => (
          AppColors.offline, theme.colorScheme.surfaceContainerHighest, Icons.help_outline,
          'Animal inconnu', 'Aucune correspondance locale'),
    };

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          const SizedBox(height: AppSpacing.md),
          Center(
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
              child: Icon(icon, size: 48, color: color),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(title, style: theme.textTheme.headlineSmall?.copyWith(color: color), textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.xs),
          Text(subtitle, style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.lg),

          if (outcome == VerifyOutcome.recognized || outcome == VerifyOutcome.stolen)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: AppRadius.card,
                border: Border.all(color: theme.dividerColor),
              ),
              child: const Column(
                children: [
                  DetailRow(label: 'Propriétaire', value: 'Issa Koné', icon: Icons.person_outline),
                  DetailRow(label: 'Village', value: 'Loumbila', icon: Icons.place_outlined),
                  DetailRow(label: 'Enrôlé le', value: '12 mai 2026', icon: Icons.event_outlined),
                  DetailRow(label: 'Identifiant', value: 'TRP-8F3A-2K', icon: Icons.tag_outlined),
                ],
              ),
            ),

          const SizedBox(height: AppSpacing.lg),
          if (outcome == VerifyOutcome.stolen)
            FilledButton.icon(
              onPressed: () {},
              style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
              icon: const Icon(Icons.sms_outlined),
              label: const Text('Alerter les autorités'),
            ),
          if (outcome == VerifyOutcome.unknown)
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_a_photo_outlined),
              label: const Text('Enrôler cet animal'),
            ),
          if (outcome == VerifyOutcome.recognized)
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Nouvelle vérification'),
            ),
        ],
      ),
    );
  }
}
