import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Bandeau d'état réseau affiché en haut des écrans.
///
/// Point central de l'app hors ligne : l'utilisateur voit d'un coup d'œil s'il
/// est connecté et combien d'éléments attendent d'être synchronisés. Rassurant
/// sur le terrain, où la connexion va et vient.
class ConnectivityIndicator extends StatelessWidget {
  const ConnectivityIndicator({
    super.key,
    required this.online,
    this.pendingCount = 0,
  });

  final bool online;
  final int pendingCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = online ? AppColors.green : AppColors.offline;
    final label = online ? 'Connecté' : 'Hors ligne';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      color: color.withValues(alpha: 0.08),
      child: Row(
        children: [
          Icon(
            online ? Icons.cloud_done_outlined : Icons.cloud_off_outlined,
            size: 18,
            color: color,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          if (pendingCount > 0) ...[
            Icon(Icons.sync_outlined, size: 16, color: AppColors.offline),
            const SizedBox(width: AppSpacing.xs),
            Text(
              '$pendingCount en attente',
              style: theme.textTheme.labelMedium?.copyWith(
                color: AppColors.offline,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
