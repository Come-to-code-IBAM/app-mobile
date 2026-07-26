import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Choix de la langue de l'interface.
class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final langs = ['Français', 'Mooré', 'Dioula', 'Fulfuldé'];
    return Scaffold(
      appBar: AppBar(title: const Text('Langue')),
      body: ListView.separated(
        padding: AppSpacing.screen,
        itemCount: langs.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, i) {
          final selected = i == 0;
          return Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: AppRadius.card,
              border: Border.all(color: selected ? AppColors.green : theme.dividerColor, width: selected ? 2 : 1),
            ),
            child: Row(
              children: [
                Expanded(child: Text(langs[i], style: theme.textTheme.titleMedium)),
                if (selected) const Icon(Icons.check_circle, color: AppColors.green),
              ],
            ),
          );
        },
      ),
    );
  }
}
