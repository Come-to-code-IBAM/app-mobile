import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/labeled_field.dart';
import '../../shared/widgets/section_header.dart';

/// Déclarer une zone cultivée (module conflit).
class DeclareZoneScreen extends StatelessWidget {
  const DeclareZoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Signaler une zone cultivée')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          const SectionHeader(eyebrow: 'Tracé', title: 'Délimiter le champ'),
          const SizedBox(height: AppSpacing.md),
          AspectRatio(
            aspectRatio: 16 / 10,
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: AppRadius.card,
                border: Border.all(color: theme.dividerColor),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.timeline_outlined, size: 36, color: theme.colorScheme.onSurface.withValues(alpha: 0.35)),
                    const SizedBox(height: AppSpacing.sm),
                    Text('Marchez le contour ou placez des points', style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.directions_walk), label: const Text('Marcher'))),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.add_location_alt_outlined), label: const Text('Points'))),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const SectionHeader(title: 'Informations'),
          const SizedBox(height: AppSpacing.md),
          const LabeledField(label: 'Nom de l\'agriculteur', hint: 'Ex. Salif Ouédraogo', prefixIcon: Icons.person_outline),
          const LabeledField(label: 'Téléphone', hint: '70 00 00 00', keyboardType: TextInputType.phone, prefixIcon: Icons.phone_outlined),
          const LabeledField(label: 'Type de culture', hint: 'Ex. maïs', optional: true),
          const LabeledField(label: 'Période de récolte', hint: 'Ex. octobre 2026', optional: true),
          const SizedBox(height: AppSpacing.sm),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            style: FilledButton.styleFrom(backgroundColor: AppColors.green),
            icon: const Icon(Icons.check),
            label: const Text('Enregistrer la zone'),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}
