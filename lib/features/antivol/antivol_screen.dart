import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/animal_list_tile.dart';
import '../../shared/widgets/connectivity_indicator.dart';
import '../../shared/widgets/module_tile.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/status_badge.dart';
import 'animal_detail_screen.dart';
import 'enroll/enroll_capture_screen.dart';
import 'found/found_capture_screen.dart';
import 'herd/herd_list_screen.dart';
import 'theft/report_theft_screen.dart';
import 'verify/verify_capture_screen.dart';

/// Module Anti-vol : enrôler, vérifier, signaler une disparition.
class AntivolScreen extends StatelessWidget {
  const AntivolScreen({super.key});

  void _open(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const BrandMark()),
      body: Column(
        children: [
          const ConnectivityIndicator(online: false, pendingCount: 2),
          Expanded(
            child: ListView(
              padding: AppSpacing.screen,
              children: [
                const SectionHeader(eyebrow: 'Anti-vol', title: 'Protéger le bétail'),
                const SizedBox(height: AppSpacing.md),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisSpacing: AppSpacing.md,
                  childAspectRatio: 0.92,
                  children: [
                    ModuleTile(
                      icon: Icons.center_focus_strong_outlined,
                      title: 'Vérifier',
                      subtitle: 'Scanner le mufle d\'un animal',
                      accent: ModuleAccents.antivol,
                      onTap: () => _open(context, const VerifyCaptureScreen()),
                    ),
                    ModuleTile(
                      icon: Icons.add_a_photo_outlined,
                      title: 'Enrôler',
                      subtitle: 'Enregistrer un nouvel animal',
                      accent: ModuleAccents.ration,
                      onTap: () => _open(context, const EnrollCaptureScreen()),
                    ),
                    ModuleTile(
                      icon: Icons.report_gmailerrorred_outlined,
                      title: 'Signaler une disparition',
                      subtitle: 'Marquer un animal comme disparu',
                      accent: ModuleAccents.antivol,
                      onTap: () => _open(context, const ReportTheftScreen()),
                    ),
                    ModuleTile(
                      icon: Icons.center_focus_weak_outlined,
                      title: 'Animal retrouvé',
                      subtitle: 'Scanner un animal retrouvé pour le signaler',
                      accent: ModuleAccents.antivol,
                      onTap: () => _open(context, const FoundCaptureScreen()),
                    ),
                    ModuleTile(
                      icon: Icons.inventory_2_outlined,
                      title: 'Mon cheptel',
                      subtitle: 'Voir les animaux enrôlés',
                      accent: ModuleAccents.carte,
                      onTap: () => _open(context, const HerdListScreen()),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                const SectionHeader(title: 'Derniers animaux'),
                const SizedBox(height: AppSpacing.md),
                AnimalListTile(
                  name: 'Zébu',
                  subtitle: 'TRP-8F3A-2K · 3 ans',
                  status: BadgeStatus.active,
                  statusLabel: 'Actif',
                  onTap: () => _open(context, const AnimalDetailScreen(name: 'Zébu', status: BadgeStatus.active, statusLabel: 'Actif')),
                ),
                const SizedBox(height: AppSpacing.sm),
                AnimalListTile(
                  name: 'Taureau',
                  subtitle: 'TRP-4K2D-0P · 4 ans',
                  status: BadgeStatus.stolen,
                  statusLabel: 'Volé',
                  onTap: () => _open(context, const AnimalDetailScreen(name: 'Taureau', status: BadgeStatus.stolen, statusLabel: 'Volé')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
