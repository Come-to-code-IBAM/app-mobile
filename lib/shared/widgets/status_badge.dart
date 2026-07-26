import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Statuts visuels d'un animal ou d'une alerte, avec code couleur cohérent.
enum BadgeStatus { active, stolen, alert, info, offline }

/// Pastille d'état colorée avec point + libellé. Utilisée sur les fiches
/// animal (actif / volé) et les alertes (conflit).
class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status, required this.label});

  final BadgeStatus status;
  final String label;

  Color get _color => switch (status) {
        BadgeStatus.active => AppColors.statusActive,
        BadgeStatus.stolen => AppColors.statusStolen,
        BadgeStatus.alert => AppColors.statusAlert,
        BadgeStatus.info => AppColors.statusInfo,
        BadgeStatus.offline => AppColors.offline,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm + 2,
        vertical: AppSpacing.xs + 1,
      ),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.12),
        borderRadius: const BorderRadius.all(AppRadius.rSm),
        border: Border.all(color: _color.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
          ),
          const SizedBox(width: AppSpacing.sm - 2),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: _color,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
