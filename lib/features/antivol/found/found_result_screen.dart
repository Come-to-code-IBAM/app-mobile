import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/detail_row.dart';

enum FoundOutcome { missing, unknown }

/// Résultat d'un scan « animal retrouvé » : disparu (à confirmer) / inconnu.
class FoundResultScreen extends StatelessWidget {
  const FoundResultScreen({super.key, required this.outcome});

  final FoundOutcome outcome;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (color, bg, icon, title, subtitle) = switch (outcome) {
      FoundOutcome.missing => (
          AppColors.success, AppColors.successLight, Icons.pets_outlined,
          'Animal retrouvé', 'Cet animal est signalé disparu'),
      FoundOutcome.unknown => (
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

          if (outcome == FoundOutcome.missing)
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
                  DetailRow(label: 'Identifiant', value: 'TRP-8F3A-2K', icon: Icons.tag_outlined),
                ],
              ),
            ),

          const SizedBox(height: AppSpacing.lg),
          if (outcome == FoundOutcome.missing)
            FilledButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              style: FilledButton.styleFrom(backgroundColor: AppColors.success),
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Confirmer l\'animal retrouvé'),
            ),
          if (outcome == FoundOutcome.unknown)
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Nouvelle recherche'),
            ),
        ],
      ),
    );
  }
}
