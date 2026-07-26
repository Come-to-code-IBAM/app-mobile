import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/section_header.dart';
import 'result_screen.dart';

/// Ration — étape 2 : aliments disponibles et prix.
class FeedsStepScreen extends StatelessWidget {
  const FeedsStepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final feeds = [
      'Tourteau de coton', 'Son de maïs', 'Fanes de niébé',
      'Paille de sorgho', 'Bloc multinutritionnel',
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Ration — 2/3 Aliments')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          const SectionHeader(eyebrow: 'Étape 2', title: 'Aliments disponibles'),
          const SizedBox(height: AppSpacing.md),
          ...feeds.map((f) => _FeedRow(name: f)),
          const SizedBox(height: AppSpacing.md),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const RationResultScreen()),
            ),
            icon: const Icon(Icons.calculate_outlined),
            label: const Text('Calculer la ration'),
          ),
        ],
      ),
    );
  }
}

class _FeedRow extends StatelessWidget {
  const _FeedRow({required this.name});
  final String name;

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
          Checkbox(value: true, onChanged: (_) {}),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: Text(name, style: theme.textTheme.titleMedium)),
          SizedBox(
            width: 96,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'FCFA/kg', isDense: true),
            ),
          ),
        ],
      ),
    );
  }
}
