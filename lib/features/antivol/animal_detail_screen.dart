import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/detail_row.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/status_badge.dart';

/// Fiche détaillée d'un animal.
class AnimalDetailScreen extends StatelessWidget {
  const AnimalDetailScreen({
    super.key,
    required this.name,
    required this.status,
    required this.statusLabel,
  });

  final String name;
  final BadgeStatus status;
  final String statusLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          Center(
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.pets_outlined, size: 44, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Center(child: StatusBadge(status: status, label: statusLabel)),
          const SizedBox(height: AppSpacing.lg),
          const SectionHeader(title: 'Informations'),
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
                DetailRow(label: 'Espèce / race', value: 'Bovin — Zébu'),
                DetailRow(label: 'Âge estimé', value: '3 ans'),
                DetailRow(label: 'Signe distinctif', value: 'Corne gauche cassée'),
                DetailRow(label: 'Identifiant', value: 'TRP-8F3A-2K'),
                DetailRow(label: 'Village', value: 'Loumbila'),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const SectionHeader(title: 'Propriétaire'),
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
                DetailRow(label: 'Nom', value: 'Issa Koné', icon: Icons.person_outline),
                DetailRow(label: 'Téléphone', value: '70 00 00 00', icon: Icons.phone_outlined),
                DetailRow(label: 'Enrôlé le', value: '12 mai 2026', icon: Icons.event_outlined),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (status != BadgeStatus.stolen)
            OutlinedButton.icon(
              onPressed: () {},
              style: OutlinedButton.styleFrom(foregroundColor: AppColors.danger, side: const BorderSide(color: AppColors.danger)),
              icon: const Icon(Icons.report_gmailerrorred_outlined),
              label: const Text('Signaler comme volé'),
            ),
        ],
      ),
    );
  }
}
