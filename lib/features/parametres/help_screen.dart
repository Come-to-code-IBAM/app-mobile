import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/section_header.dart';

/// Aide et mode d'emploi rapide.
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entries = [
      (Icons.verified_user_outlined, 'Anti-vol', 'Enrôler, vérifier et signaler le vol d\'un animal par son mufle.'),
      (Icons.grass_outlined, 'Ration', 'Calculer la ration la moins chère selon les aliments disponibles.'),
      (Icons.map_outlined, 'Carte', 'Voir les couloirs, déclarer une zone, être alerté des conflits.'),
      (Icons.cloud_off_outlined, 'Hors ligne', 'Tout fonctionne sans réseau ; les données se synchronisent plus tard.'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Aide')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          const SectionHeader(eyebrow: 'Mode d\'emploi', title: 'Comment ça marche'),
          const SizedBox(height: AppSpacing.md),
          ...entries.map((e) => Container(
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: AppRadius.card,
                  border: Border.all(color: theme.dividerColor),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(e.$1, color: theme.colorScheme.primary),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.$2, style: theme.textTheme.titleMedium),
                          const SizedBox(height: 2),
                          Text(e.$3, style: theme.textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
