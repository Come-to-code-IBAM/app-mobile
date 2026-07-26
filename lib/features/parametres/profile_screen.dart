import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/labeled_field.dart';
import '../../shared/widgets/section_header.dart';

/// Édition du profil de l'utilisateur.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mon compte')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          const SectionHeader(title: 'Informations personnelles'),
          const SizedBox(height: AppSpacing.md),
          const LabeledField(label: 'Nom complet', hint: 'Ex. Issa Koné', prefixIcon: Icons.person_outline),
          const LabeledField(label: 'Téléphone', hint: '70 00 00 00', keyboardType: TextInputType.phone, prefixIcon: Icons.phone_outlined),
          const LabeledField(label: 'Village', hint: 'Ex. Loumbila', prefixIcon: Icons.place_outlined),
          const LabeledDropdown(label: 'Rôle', value: 'Éleveur', items: ['Éleveur', 'Agent', 'Administrateur']),
          const SizedBox(height: AppSpacing.sm),
          FilledButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Enregistrer')),
        ],
      ),
    );
  }
}
