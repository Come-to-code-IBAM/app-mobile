import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/camera_frame.dart';
import 'enroll_form_screen.dart';

/// Étape 1 de l'enrôlement : capturer le mufle de l'animal.
class EnrollCaptureScreen extends StatefulWidget {
  const EnrollCaptureScreen({super.key});

  @override
  State<EnrollCaptureScreen> createState() => _EnrollCaptureScreenState();
}

class _EnrollCaptureScreenState extends State<EnrollCaptureScreen> {
  final _picker = ImagePicker();
  bool _loading = false;
  File? _preview;

  Future<void> _capture() async {
    setState(() => _loading = true);
    try {
      final xfile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        preferredCameraDevice: CameraDevice.rear,
      );
      if (xfile == null) return; // l'utilisateur a annulé
      final file = File(xfile.path);
      final bytes = await file.readAsBytes();
      if (!mounted) return;
      setState(() => _preview = file);
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => EnrollFormScreen(muzzleImageBytes: bytes),
        ),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Enrôler — photo du mufle')),
      body: Padding(
        padding: AppSpacing.screen,
        child: Column(
          children: [
            _preview != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(_preview!, height: 220, fit: BoxFit.cover),
                  )
                : const CameraFrame(),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Cadrez bien le mufle avant de prendre la photo.',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            _loading
                ? const CircularProgressIndicator()
                : FilledButton.icon(
                    onPressed: _capture,
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