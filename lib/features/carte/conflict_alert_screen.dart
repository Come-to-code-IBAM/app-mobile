import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Alerte plein écran : approche d'une zone cultivée.
/// Le berger est alerté localement ; l'agriculteur via la cascade A/B/C.
class ConflictAlertScreen extends StatelessWidget {
  const ConflictAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.statusAlert,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screen,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning_amber_rounded, size: 96, color: Colors.white),
              const SizedBox(height: AppSpacing.lg),
              Text('Zone cultivée proche', style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white), textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Champ de maïs à 480 m devant vous.\nÉvitez de traverser.',
                style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: AppRadius.card,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.sms_outlined, color: Colors.white, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(child: Text('L\'agriculteur a été prévenu (plan A).', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white))),
                  ],
                ),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () => Navigator.of(context).maybePop(),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.statusAlert,
                ),
                child: const Text('J\'ai compris'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
