import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/section_header.dart';
import 'feeds_step_screen.dart';

/// Ration — étape 1 : composition du troupeau à nourrir.
class HerdStepScreen extends StatelessWidget {
  const HerdStepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ration — 1/3 Troupeau')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          const SectionHeader(eyebrow: 'Étape 1', title: 'Mon troupeau'),
          const SizedBox(height: AppSpacing.md),
          const _CounterRow(label: 'Vaches en entretien', value: 6),
          const _CounterRow(label: 'Vaches gestantes', value: 2),
          const _CounterRow(label: 'Jeunes en croissance', value: 4),
          const _CounterRow(label: 'Vaches en lactation', value: 3),
          const SizedBox(height: AppSpacing.md),
          FilledButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const FeedsStepScreen()),
            ),
            child: const Text('Continuer'),
          ),
        ],
      ),
    );
  }
}

class _CounterRow extends StatelessWidget {
  const _CounterRow({required this.label, required this.value});
  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          Expanded(child: Text(label, style: theme.textTheme.titleMedium)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.remove_circle_outline)),
          Text('$value', style: theme.textTheme.titleLarge),
          IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle_outline)),
        ],
      ),
    );
  }
}
