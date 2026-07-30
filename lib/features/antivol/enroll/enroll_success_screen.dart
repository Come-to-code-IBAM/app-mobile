import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

/// Étape 3 de l'enrôlement : confirmation + identifiant local attribué.
class EnrollSuccessScreen extends StatelessWidget {
  const EnrollSuccessScreen({super.key, required this.localUuid});

  final String localUuid;

  // Identifiant court lisible (8 premiers caractères du uuid).
  String get _shortId => localUuid.replaceAll('-', '').substring(0, 8).toUpperCase();

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
              decoration: const BoxDecoration(
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
                  Text('Identifiant local', style: theme.textTheme.labelMedium),
                  const SizedBox(height: AppSpacing.xs),
                  Text('TRP-$_shortId', style: theme.textTheme.headlineSmall),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'L\'identifiant définitif sera assigné après synchro.',
                    style: theme.textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Spacer(),
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