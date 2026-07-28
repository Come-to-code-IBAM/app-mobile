import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/models/ration_result.dart';
import '../../core/app/app_scope.dart';
import '../../shared/widgets/detail_row.dart';
import '../../shared/widgets/section_header.dart';
import 'history_screen.dart';

/// Ration — étape 3 : mélange optimal et coût.
class RationResultScreen extends StatelessWidget {
  const RationResultScreen({super.key, required this.result});

  final RationResult result;

  Future<void> _saveRation(BuildContext context) async {
    final repository = AppScope.of(context).rationRepository;
    debugPrint('[RationResultScreen] save request local_uuid=${result.localUuid}');
    try {
      await repository.saveResult(result);
      debugPrint('[RationResultScreen] save persisted local_uuid=${result.localUuid}');

      final history = await repository.history();
      final saved = history.any((item) => item.localUuid == result.localUuid);
      debugPrint('[RationResultScreen] save verification saved=$saved historyCount=${history.length}');

      if (!saved) {
        throw StateError('La ration a été enregistrée, mais elle n’a pas été retrouvée en historique.');
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ration enregistrée dans l’historique (${history.length} total)')),
        );
      }
    } catch (error, stackTrace) {
      debugPrint('[RationResultScreen] save error: $error');
      debugPrint(stackTrace.toString());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de l’enregistrement : ${error.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Ration — Résultat')),
      body: SafeArea(
        child: ListView(
          padding: AppSpacing.screen,
          children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.successLight,
              borderRadius: AppRadius.card,
            ),
            child: Column(
              children: [
                Text('Coût de la ration', style: theme.textTheme.labelMedium),
                const SizedBox(height: AppSpacing.xs),
                Text('${result.totalCost.toStringAsFixed(0)} FCFA / jour', style: theme.textTheme.displaySmall?.copyWith(color: AppColors.success)),
                const SizedBox(height: AppSpacing.xs),
                Text('Économie estimée : ${result.totalCost > 0 ? (result.totalCost * 0.2).toStringAsFixed(0) : '0'} FCFA/jour', style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.success)),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const SectionHeader(title: 'Mélange recommandé'),
          Container(
            margin: const EdgeInsets.only(top: AppSpacing.sm),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: AppRadius.card,
              border: Border.all(color: theme.dividerColor),
            ),
            child: Column(
              children: result.mixResult.map((item) => DetailRow(
                    label: item['name']?.toString() ?? 'Aliment',
                    value: '${item['quantityKg']} kg',
                  )).toList(),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.successLight,
              borderRadius: AppRadius.card,
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle_outline, color: AppColors.success, size: 20),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: Text('Besoins en énergie et protéines couverts.', style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.success))),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton.icon(onPressed: () => _saveRation(context), icon: const Icon(Icons.save_outlined), label: const Text('Enregistrer cette ration')),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RationHistoryScreen())), child: const Text('Voir l’historique')),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Recalculer')),
          ],
        ),
      ),
    );
  }
}
