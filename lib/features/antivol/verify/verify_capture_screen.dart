import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/camera_frame.dart';
import 'verify_result_screen.dart';

/// Vérification d'un animal : scanner le mufle et comparer.
class VerifyCaptureScreen extends StatelessWidget {
  const VerifyCaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Vérifier un animal')),
      body: Padding(
        padding: AppSpacing.screen,
        child: Column(
          children: [
            const CameraFrame(hint: 'Cadrez le mufle à vérifier'),
            const SizedBox(height: AppSpacing.md),
            Text(
              'La comparaison se fait localement, sans connexion.',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            // Boutons de simulation des trois issues (gabarit)
            FilledButton.icon(
              onPressed: () => _go(context, VerifyOutcome.recognized),
              icon: const Icon(Icons.center_focus_strong_outlined),
              label: const Text('Scanner'),
            ),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              alignment: WrapAlignment.center,
              children: [
                TextButton(onPressed: () => _go(context, VerifyOutcome.recognized), child: const Text('→ reconnu')),
                TextButton(onPressed: () => _go(context, VerifyOutcome.stolen), child: const Text('→ volé')),
                TextButton(onPressed: () => _go(context, VerifyOutcome.unknown), child: const Text('→ inconnu')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _go(BuildContext context, VerifyOutcome outcome) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => VerifyResultScreen(outcome: outcome)),
    );
  }
}
