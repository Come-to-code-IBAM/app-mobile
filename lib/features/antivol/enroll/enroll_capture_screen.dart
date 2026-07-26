import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/camera_frame.dart';
import 'enroll_form_screen.dart';

/// Étape 1 de l'enrôlement : capturer le mufle de l'animal.
class EnrollCaptureScreen extends StatelessWidget {
  const EnrollCaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Enrôler — photo du mufle')),
      body: Padding(
        padding: AppSpacing.screen,
        child: Column(
          children: [
            const CameraFrame(),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Trois photos seront prises pour fiabiliser la signature.',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const EnrollFormScreen()),
              ),
              icon: const Icon(Icons.camera_alt_outlined),
              label: const Text('Prendre la photo'),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              onPressed: () {},
              child: const Text('Identifier par boucle QR à la place'),
            ),
          ],
        ),
      ),
    );
  }
}
