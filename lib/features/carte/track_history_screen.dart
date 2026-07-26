import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';

/// Historique des trajets de transhumance enregistrés.
class TrackHistoryScreen extends StatelessWidget {
  const TrackHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = [
      ('25 juillet 2026', '8,4 km', 'Loumbila → Ziniaré'),
      ('24 juillet 2026', '6,1 km', 'Ziniaré → mare de Bam'),
      ('22 juillet 2026', '11,2 km', 'Bam → Loumbila'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Historique de trajet')),
      body: ListView.separated(
        padding: AppSpacing.screen,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, i) {
          final (date, dist, route) = items[i];
          return Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: AppRadius.card,
              border: Border.all(color: theme.dividerColor),
            ),
            child: Row(
              children: [
                const Icon(Icons.route_outlined),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(date, style: theme.textTheme.titleMedium),
                      Text('$route · $dist', style: theme.textTheme.bodyMedium),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
