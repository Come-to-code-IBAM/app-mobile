import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/section_header.dart';

/// État détaillé de la synchronisation hors ligne.
class SyncScreen extends StatelessWidget {
  const SyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Synchronisation')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: AppRadius.card,
            ),
            child: Column(
              children: [
                const Icon(Icons.cloud_off_outlined, size: 40, color: AppColors.offline),
                const SizedBox(height: AppSpacing.sm),
                Text('Hors ligne', style: theme.textTheme.titleLarge),
                Text('2 éléments en attente d\'envoi', style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const SectionHeader(title: 'En attente'),
          const SizedBox(height: AppSpacing.sm),
          _PendingRow(icon: Icons.pets_outlined, label: 'Enrôlement — Génisse', time: 'il y a 2 h'),
          _PendingRow(icon: Icons.grass_outlined, label: 'Ration — 15 têtes', time: 'il y a 5 h'),
          const SizedBox(height: AppSpacing.lg),
          FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.sync), label: const Text('Synchroniser maintenant')),
          const SizedBox(height: AppSpacing.sm),
          Center(child: Text('Dernière synchro : jamais', style: theme.textTheme.labelMedium)),
        ],
      ),
    );
  }
}

class _PendingRow extends StatelessWidget {
  const _PendingRow({required this.icon, required this.label, required this.time});
  final IconData icon;
  final String label;
  final String time;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.offline),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Text(label, style: theme.textTheme.titleMedium)),
          Text(time, style: theme.textTheme.labelMedium),
        ],
      ),
    );
  }
}
