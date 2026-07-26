import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/connectivity_indicator.dart';
import '../../shared/widgets/section_header.dart';
import 'conflict_alert_screen.dart';
import 'declare_zone_screen.dart';
import 'track_history_screen.dart';

/// Module Carte : couloirs de transhumance et zones cultivées.
class CarteScreen extends StatelessWidget {
  const CarteScreen({super.key});

  void _open(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carte'),
        actions: [
          IconButton(
            onPressed: () => _open(context, const TrackHistoryScreen()),
            icon: const Icon(Icons.route_outlined),
            tooltip: 'Historique de trajet',
          ),
        ],
      ),
      body: Column(
        children: [
          const ConnectivityIndicator(online: false),
          Expanded(
            child: ListView(
              padding: AppSpacing.screen,
              children: [
                const SectionHeader(eyebrow: 'Transhumance', title: 'Couloirs et zones'),
                const SizedBox(height: AppSpacing.md),
                AspectRatio(
                  aspectRatio: 3 / 4,
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
                          Icon(Icons.map_outlined, size: 40, color: theme.colorScheme.onSurface.withValues(alpha: 0.35)),
                          const SizedBox(height: AppSpacing.sm),
                          Text('Carte hors ligne', style: theme.textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.md,
                  children: const [
                    _Legend(color: AppColors.green, label: 'Couloirs'),
                    _Legend(color: AppColors.statusStolen, label: 'Zones cultivées'),
                    _Legend(color: AppColors.statusAlert, label: 'Alerte conflit'),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                FilledButton.icon(
                  onPressed: () => _open(context, const DeclareZoneScreen()),
                  icon: const Icon(Icons.add_location_alt_outlined),
                  label: const Text('Signaler une zone cultivée'),
                ),
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton.icon(
                  onPressed: () => _open(context, const ConflictAlertScreen()),
                  icon: const Icon(Icons.warning_amber_outlined),
                  label: const Text('Aperçu alerte de conflit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: AppSpacing.xs),
        Text(label, style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}
