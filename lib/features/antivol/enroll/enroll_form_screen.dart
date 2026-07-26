import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/labeled_field.dart';
import '../../../shared/widgets/section_header.dart';
import 'enroll_success_screen.dart';

/// Étape 2 de l'enrôlement : renseigner l'animal et son propriétaire.
class EnrollFormScreen extends StatelessWidget {
  const EnrollFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enrôler — informations')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          const SectionHeader(eyebrow: 'Propriétaire', title: 'Éleveur'),
          const SizedBox(height: AppSpacing.md),
          const LabeledField(label: 'Nom du propriétaire', hint: 'Ex. Issa Koné', prefixIcon: Icons.person_outline),
          const LabeledField(label: 'Téléphone', hint: '70 00 00 00', keyboardType: TextInputType.phone, prefixIcon: Icons.phone_outlined),
          const LabeledField(label: 'Village', hint: 'Ex. Loumbila', prefixIcon: Icons.place_outlined),
          const SizedBox(height: AppSpacing.sm),
          const SectionHeader(eyebrow: 'Animal', title: 'Caractéristiques'),
          const SizedBox(height: AppSpacing.md),
          const LabeledDropdown(label: 'Espèce', value: 'Bovin', items: ['Bovin', 'Ovin', 'Caprin', 'Asin', 'Autre']),
          const LabeledField(label: 'Race', hint: 'Ex. Zébu', optional: true),
          const LabeledField(label: 'Âge estimé (années)', hint: 'Ex. 3', keyboardType: TextInputType.number, optional: true),
          const LabeledField(label: 'Signe distinctif', hint: 'Ex. corne gauche cassée', optional: true),
          const SizedBox(height: AppSpacing.sm),
          const SectionHeader(eyebrow: 'Témoin', title: 'Optionnel'),
          const SizedBox(height: AppSpacing.md),
          const LabeledField(label: 'Nom du témoin', hint: 'Ex. Chef de village', optional: true),
          const LabeledField(label: 'Téléphone du témoin', keyboardType: TextInputType.phone, optional: true),
          const SizedBox(height: AppSpacing.md),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const EnrollSuccessScreen()),
            ),
            icon: const Icon(Icons.check),
            label: const Text('Enregistrer l\'animal'),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}
