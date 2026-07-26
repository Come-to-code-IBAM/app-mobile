import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/camera_frame.dart';
import 'found_result_screen.dart';

/// Signaler un animal retrouvé : scanner le mufle pour identifier
/// l'animal et, s'il est signalé disparu, prévenir son propriétaire.
class FoundCaptureScreen extends StatelessWidget {
  const FoundCaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Animal retrouvé')),
      body: Padding(
        padding: AppSpacing.screen,
        child: Column(
          children: [
            const CameraFrame(hint: 'Cadrez le mufle de l\'animal retrouvé'),
            const SizedBox(height: AppSpacing.md),
            Text(
              'La comparaison se fait localement, sans connexion.',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            // Boutons de simulation des issues (gabarit)
            FilledButton.icon(
              onPressed: () => _go(context, FoundOutcome.missing),
              icon: const Icon(Icons.center_focus_weak_outlined),
              label: const Text('Scanner'),
            ),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              alignment: WrapAlignment.center,
              children: [
                TextButton(onPressed: () => _go(context, FoundOutcome.missing), child: const Text('→ signalé disparu')),
                TextButton(onPressed: () => _go(context, FoundOutcome.unknown), child: const Text('→ inconnu')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _go(BuildContext context, FoundOutcome outcome) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => FoundResultScreen(outcome: outcome)),
    );
  }
}
