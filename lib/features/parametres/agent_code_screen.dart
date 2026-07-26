import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/labeled_field.dart';
import '../../shared/widgets/section_header.dart';

/// Saisie du code d'habilitation d'agent (débloque l'enrôlement).
class AgentCodeScreen extends StatelessWidget {
  const AgentCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Code d\'agent')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          const SectionHeader(title: 'Habilitation'),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'L\'enrôlement d\'animaux est réservé aux agents habilités. '
            'Saisissez le code fourni par le service d\'élevage.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          const LabeledField(label: 'Code d\'agent', hint: 'Ex. AGT-2026-014', prefixIcon: Icons.lock_outline),
          const SizedBox(height: AppSpacing.sm),
          FilledButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Valider le code')),
        ],
      ),
    );
  }
}
