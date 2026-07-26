import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/animal_list_tile.dart';
import '../../../shared/widgets/status_badge.dart';
import '../animal_detail_screen.dart';

/// Liste des animaux enrôlés (le cheptel de l'utilisateur).
class HerdListScreen extends StatelessWidget {
  const HerdListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Zébu', 'TRP-8F3A-2K · 3 ans', BadgeStatus.active, 'Actif'),
      ('Vache laitière', 'TRP-1B7C-9M · 5 ans', BadgeStatus.active, 'Actif'),
      ('Taureau', 'TRP-4K2D-0P · 4 ans', BadgeStatus.stolen, 'Volé'),
      ('Génisse', 'TRP-9X1A-3T · 2 ans', BadgeStatus.active, 'Actif'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Mon cheptel')),
      body: ListView.separated(
        padding: AppSpacing.screen,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, i) {
          final (name, sub, status, label) = items[i];
          return AnimalListTile(
            name: name,
            subtitle: sub,
            status: status,
            statusLabel: label,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => AnimalDetailScreen(name: name, status: status, statusLabel: label)),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Enrôler'),
      ),
    );
  }
}
