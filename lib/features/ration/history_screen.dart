import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';

/// Historique des rations calculées.
class RationHistoryScreen extends StatelessWidget {
  const RationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = [
      ('24 juillet 2026', '4 250 FCFA/jour', '15 têtes'),
      ('18 juillet 2026', '4 800 FCFA/jour', '15 têtes'),
      ('10 juillet 2026', '3 900 FCFA/jour', '12 têtes'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Historique des rations')),
      body: ListView.separated(
        padding: AppSpacing.screen,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, i) {
          final (date, cost, herd) = items[i];
          return Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: AppRadius.card,
              border: Border.all(color: theme.dividerColor),
            ),
            child: Row(
              children: [
                const Icon(Icons.grass_outlined),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(date, style: theme.textTheme.titleMedium),
                      Text('$herd · $cost', style: theme.textTheme.bodyMedium),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          );
        },
      ),
    );
  }
}
