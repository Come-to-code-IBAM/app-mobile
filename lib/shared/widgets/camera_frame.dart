import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Aperçu caméra avec cadre-guide pour cadrer le mufle.
/// Placeholder visuel — le flux caméra réel sera branché plus tard.
class CameraFrame extends StatelessWidget {
  const CameraFrame({super.key, this.hint = 'Placez le mufle dans le cadre'});

  final String hint;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: AppRadius.card,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.photo_camera_outlined, size: 44, color: Colors.white24),
            // Cadre-guide
            Container(
              margin: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.greenBright, width: 2.5),
                borderRadius: AppRadius.card,
              ),
            ),
            Positioned(
              bottom: AppSpacing.md,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  hint,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
