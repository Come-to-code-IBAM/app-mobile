import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/labeled_field.dart';
import '../../../shared/widgets/section_header.dart';

/// Signaler un vol : sélectionner l'animal puis décrire les circonstances.
class ReportTheftScreen extends StatelessWidget {
  const ReportTheftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Signaler un vol')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          const SectionHeader(eyebrow: 'Animal', title: 'Lequel a été volé ?'),
          const SizedBox(height: AppSpacing.md),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Rechercher par nom, identifiant…',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.dangerLight,
              borderRadius: AppRadius.card,
              border: Border.all(color: AppColors.danger.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.pets_outlined, color: AppColors.danger),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Zébu — TRP-8F3A-2K', style: theme.textTheme.titleMedium),
                      Text('Propriétaire : Issa Koné', style: theme.textTheme.bodyMedium),
                    ],
                  ),
                ),
                const Icon(Icons.check_circle, color: AppColors.danger),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const SectionHeader(title: 'Circonstances'),
          const SizedBox(height: AppSpacing.md),
          const LabeledField(label: 'Date approximative', hint: 'Ex. 20 juillet 2026', prefixIcon: Icons.event_outlined),
          const LabeledField(label: 'Lieu', hint: 'Ex. pâturage de Loumbila', prefixIcon: Icons.place_outlined, optional: true),
          const LabeledField(label: 'Détails', hint: 'Décrivez ce qui s\'est passé', maxLines: 4, optional: true),
          const SizedBox(height: AppSpacing.sm),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            icon: const Icon(Icons.report_outlined),
            label: const Text('Confirmer le signalement'),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}
