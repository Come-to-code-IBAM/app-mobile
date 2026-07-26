import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/connectivity_indicator.dart';
import '../../shared/widgets/module_tile.dart';
import '../../shared/widgets/section_header.dart';
import 'herd_step_screen.dart';
import 'history_screen.dart';

/// Module Ration : point d'entrée vers le calcul et l'historique.
class RationScreen extends StatelessWidget {
  const RationScreen({super.key});

  void _open(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Ration')),
      body: Column(
        children: [
          const ConnectivityIndicator(online: false),
          Expanded(
            child: ListView(
              padding: AppSpacing.screen,
              children: [
                const SectionHeader(eyebrow: 'Ration', title: 'Nourrir au meilleur coût'),
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: AppRadius.card,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Calculer une nouvelle ration',
                          style: theme.textTheme.titleLarge?.copyWith(color: Colors.white)),
                      const SizedBox(height: AppSpacing.xs),
                      Text('Le mélange le moins cher qui couvre les besoins de votre troupeau.',
                          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70)),
                      const SizedBox(height: AppSpacing.md),
                      FilledButton(
                        onPressed: () => _open(context, const HerdStepScreen()),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: theme.colorScheme.primary,
                        ),
                        child: const Text('Commencer'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                ModuleTile(
                  icon: Icons.history,
                  title: 'Historique des rations',
                  subtitle: 'Consulter les calculs précédents',
                  accent: ModuleAccents.ration,
                  onTap: () => _open(context, const RationHistoryScreen()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
