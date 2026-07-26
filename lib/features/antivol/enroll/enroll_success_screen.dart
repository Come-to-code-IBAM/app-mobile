import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

/// Étape 3 de l'enrôlement : confirmation + identifiant attribué.
class EnrollSuccessScreen extends StatelessWidget {
  const EnrollSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: AppSpacing.screen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: AppColors.successLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_rounded, size: 48, color: AppColors.success),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Animal enrôlé', style: theme.textTheme.headlineSmall, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Sera synchronisé dès qu\'une connexion sera disponible.',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: AppRadius.card,
              ),
              child: Column(
                children: [
                  Text('Identifiant de l\'animal', style: theme.textTheme.labelMedium),
                  const SizedBox(height: AppSpacing.xs),
                  Text('TRP-8F3A-2K', style: theme.textTheme.headlineSmall),
                ],
              ),
            ),
            const Spacer(),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.qr_code_2_outlined),
              label: const Text('Imprimer / partager l\'identifiant'),
            ),
            const SizedBox(height: AppSpacing.sm),
            FilledButton(
              onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
              child: const Text('Terminer'),
            ),
          ],
        ),
      ),
    );
  }
}
