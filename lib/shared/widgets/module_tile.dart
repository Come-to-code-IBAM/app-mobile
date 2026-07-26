import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Grande tuile d'action pour le menu d'accueil.
///
/// Volontairement large et lisible : icône, titre, sous-titre. Pensée pour des
/// utilisateurs peu à l'aise avec la technologie — une cible tactile généreuse
/// et un accent coloré par module.
class ModuleTile extends StatelessWidget {
  const ModuleTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: AppRadius.card,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.card,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: AppRadius.card,
            border: Border.all(color: theme.dividerColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: const BorderRadius.all(AppRadius.rMd),
                ),
                child: Icon(icon, color: accent, size: 26),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(title, style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle,
                style: theme.textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Accents de couleur par module, cohérents avec le reste de l'app.
abstract final class ModuleAccents {
  static const Color antivol = AppColors.statusStolen;
  static const Color ration = AppColors.navy;
  static const Color carte = AppColors.green;
  static const Color parametres = AppColors.offline;
}
