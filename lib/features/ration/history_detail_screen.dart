import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../data/models/ration_result.dart';

class RationHistoryDetailScreen extends StatelessWidget {
  const RationHistoryDetailScreen({super.key, required this.ration});

  final RationResult ration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final herdEntries = ration.herdSnapshot.entries
        .map((entry) => '${entry.key}: ${entry.value}')
        .toList();
    final mixEntries = ration.mixResult.map((entry) {
      final name = entry['name']?.toString() ?? 'Aliment';
      final quantity = (entry['quantityKg'] as num?)?.toDouble() ?? 0.0;
      final price = (entry['pricePerKg'] as num?)?.toDouble() ?? 0.0;
      return '$name — ${quantity.toStringAsFixed(1)} kg à ${price.toStringAsFixed(0)} FCFA/kg';
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Détail de la ration')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: AppRadius.card,
              border: Border.all(color: theme.dividerColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Résumé', style: theme.textTheme.titleLarge),
                const SizedBox(height: AppSpacing.md),
                Text(
                    'Date : ${ration.createdAt.toLocal().toString().split(' ').first}',
                    style: theme.textTheme.bodyMedium),
                const SizedBox(height: AppSpacing.xs),
                Text('Coût : ${ration.totalCost.toStringAsFixed(0)} FCFA/jour',
                    style: theme.textTheme.bodyMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(
                    'Troupeau : ${ration.herdSnapshot.values.fold<int>(0, (sum, value) => sum + (value is num ? value.toInt() : 0))} têtes',
                    style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Composition du troupeau', style: theme.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          ...herdEntries.map((entry) => Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: AppRadius.card,
                  border: Border.all(color: theme.dividerColor),
                ),
                child: Text(entry, style: theme.textTheme.bodyMedium),
              )),
          const SizedBox(height: AppSpacing.lg),
          Text('Détails du mélange', style: theme.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          ...mixEntries.map((entry) => Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: AppRadius.card,
                  border: Border.all(color: theme.dividerColor),
                ),
                child: Text(entry, style: theme.textTheme.bodyMedium),
              )),
        ],
      ),
    );
  }
}
