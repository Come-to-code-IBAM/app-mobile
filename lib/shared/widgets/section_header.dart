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

/// Marque de l'application : le logo, dans une carte claire pour rester lisible
/// aussi bien sur fond sombre (splash) que sur fond clair.
class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final logoHeight = compact ? 32.0 : 40.0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.xs),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(AppRadius.rMd),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            'assets/images/logo.jpeg',
            height: logoHeight,
            fit: BoxFit.contain,
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
