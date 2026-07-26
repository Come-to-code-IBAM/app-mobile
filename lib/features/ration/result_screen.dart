import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/detail_row.dart';
import '../../shared/widgets/section_header.dart';

/// Ration — étape 3 : mélange optimal et coût.
class RationResultScreen extends StatelessWidget {
  const RationResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Ration — Résultat')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.successLight,
              borderRadius: AppRadius.card,
            ),
            child: Column(
              children: [
                Text('Coût de la ration', style: theme.textTheme.labelMedium),
                const SizedBox(height: AppSpacing.xs),
                Text('4 250 FCFA / jour', style: theme.textTheme.displaySmall?.copyWith(color: AppColors.success)),
                const SizedBox(height: AppSpacing.xs),
                Text('Économie estimée : 1 100 FCFA/jour', style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.success)),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const SectionHeader(title: 'Mélange recommandé'),
          Container(
            margin: const EdgeInsets.only(top: AppSpacing.sm),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: AppRadius.card,
              border: Border.all(color: theme.dividerColor),
            ),
            child: const Column(
              children: [
                DetailRow(label: 'Son de maïs', value: '18 kg'),
                DetailRow(label: 'Tourteau de coton', value: '9 kg'),
                DetailRow(label: 'Fanes de niébé', value: '12 kg'),
                DetailRow(label: 'Paille de sorgho', value: '25 kg'),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.successLight,
              borderRadius: AppRadius.card,
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle_outline, color: AppColors.success, size: 20),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: Text('Besoins en énergie et protéines couverts.', style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.success))),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.save_outlined), label: const Text('Enregistrer cette ration')),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Recalculer')),
        ],
      ),
    );
  }
}
