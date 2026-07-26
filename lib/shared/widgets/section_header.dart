import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// En-tête de section : un court libellé en capitales douces au-dessus d'un
/// titre. Structure la lecture des écrans sans surcharger.
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.eyebrow});

  final String title;
  final String? eyebrow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (eyebrow != null) ...[
          Text(
            eyebrow!.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              color: AppColors.green,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
        Text(title, style: theme.textTheme.titleLarge),
      ],
    );
  }
}

/// Marque de l'application : le monogramme entre chevrons, clin d'œil au logo
/// C2I « <C2I/> » de l'affiche, décliné pour le carnet du troupeau.
class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm + 2,
            vertical: AppSpacing.xs + 2,
          ),
          decoration: BoxDecoration(
            color: AppColors.navy,
            borderRadius: const BorderRadius.all(AppRadius.rMd),
          ),
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: '<',
                  style: TextStyle(color: AppColors.greenBright),
                ),
                TextSpan(
                  text: 'Troupeau',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const TextSpan(
                  text: '/>',
                  style: TextStyle(color: AppColors.greenBright),
                ),
              ],
            ),
          ),
        ),
        if (!compact) ...[
          const SizedBox(width: AppSpacing.sm),
          Text(
            'Carnet numérique',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ],
    );
  }
}
