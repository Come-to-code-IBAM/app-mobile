import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import 'status_badge.dart';

/// Ligne d'animal dans une liste (cheptel, résultats).
class AnimalListTile extends StatelessWidget {
  const AnimalListTile({
    super.key,
    required this.name,
    required this.subtitle,
    required this.status,
    required this.statusLabel,
    this.onTap,
  });

  final String name;
  final String subtitle;
  final BadgeStatus status;
  final String statusLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: AppRadius.card,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.card,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: AppRadius.card,
            border: Border.all(color: theme.dividerColor),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: const BorderRadius.all(AppRadius.rMd),
                ),
                child: Icon(Icons.pets_outlined, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(subtitle, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
              StatusBadge(status: status, label: statusLabel),
            ],
          ),
        ),
      ),
    );
  }
}
