import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/app/app_scope.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/repositories/animal_repository.dart';
import '../../../shared/widgets/camera_frame.dart';
import 'verify_result_screen.dart';

/// Vérification d'un animal : capturer le mufle et comparer.
class VerifyCaptureScreen extends StatefulWidget {
  const VerifyCaptureScreen({super.key});

  @override
  State<VerifyCaptureScreen> createState() => _VerifyCaptureScreenState();
}

class _VerifyCaptureScreenState extends State<VerifyCaptureScreen> {
  final _picker = ImagePicker();
  bool _loading = false;
  File? _preview;

  Future<void> _scan() async {
    setState(() => _loading = true);
    try {
      final xfile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        preferredCameraDevice: CameraDevice.rear,
      );
      if (xfile == null) {
        setState(() => _loading = false);
        return;
      }
      final bytes = await File(xfile.path).readAsBytes();
      if (!mounted) return;
      setState(() => _preview = File(xfile.path));

      final repo = AppScope.of(context).animalRepository;
      final result = await repo.verifyByImage(bytes);

      if (!mounted) return;
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => VerifyResultScreen(
            outcome: _toUiOutcome(result.outcome),
            animal: result.animal,
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  VerifyOutcome _toUiOutcome(VerifyOutcome outcome) => outcome;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Vérifier un animal')),
      body: Padding(
        padding: AppSpacing.screen,
        child: Column(
          children: [
            _preview != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(_preview!, height: 220, fit: BoxFit.cover),
                  )
                : const CameraFrame(hint: 'Cadrez le mufle à vérifier'),
            const SizedBox(height: AppSpacing.md),
            Text(
              'La comparaison se fait localement si hors ligne,\nvia le serveur si connecté.',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            _loading
                ? const CircularProgressIndicator()
                : FilledButton.icon(
                    onPressed: _scan,
                    icon: const Icon(Icons.center_focus_strong_outlined),
                    label: const Text('Scanner'),
                  ),
          ],
        ),
      ),
    );
  }
}