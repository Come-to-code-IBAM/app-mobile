import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/status_badge.dart';
import 'agent_code_screen.dart';
import 'help_screen.dart';
import 'language_screen.dart';
import 'profile_screen.dart';
import 'sync_screen.dart';

/// Module Réglages : profil, synchronisation, langue, habilitations, aide.
class ParametresScreen extends StatelessWidget {
  const ParametresScreen({super.key});

  void _open(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Réglages')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          const SectionHeader(eyebrow: 'Profil', title: 'Mon compte'),
          const SizedBox(height: AppSpacing.md),
          _Tile(icon: Icons.person_outline, title: 'Nom et village', subtitle: 'Non renseigné', onTap: () => _open(context, const ProfileScreen())),
          const _Tile(icon: Icons.badge_outlined, title: 'Rôle', trailing: StatusBadge(status: BadgeStatus.info, label: 'Éleveur')),
          const SizedBox(height: AppSpacing.lg),
          const SectionHeader(title: 'Synchronisation'),
          const SizedBox(height: AppSpacing.md),
          _Tile(icon: Icons.sync_outlined, title: 'Éléments en attente', subtitle: '2 éléments', onTap: () => _open(context, const SyncScreen())),
          _Tile(icon: Icons.cloud_sync_outlined, title: 'Synchroniser maintenant', subtitle: 'Dernière synchro : jamais', onTap: () => _open(context, const SyncScreen())),
          const SizedBox(height: AppSpacing.lg),
          const SectionHeader(title: 'Préférences'),
          const SizedBox(height: AppSpacing.md),
          _Tile(icon: Icons.translate_outlined, title: 'Langue', subtitle: 'Français', onTap: () => _open(context, const LanguageScreen())),
          _Tile(icon: Icons.lock_outline, title: 'Code d\'agent', subtitle: 'Débloque l\'enrôlement', onTap: () => _open(context, const AgentCodeScreen())),
          _Tile(icon: Icons.help_outline, title: 'Aide', subtitle: 'Mode d\'emploi', onTap: () => _open(context, const HelpScreen())),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.icon, required this.title, this.subtitle, this.trailing, this.onTap});

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Material(
        color: theme.colorScheme.surface,
        borderRadius: AppRadius.card,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.card,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: AppRadius.card,
              border: Border.all(color: theme.dividerColor),
            ),
            child: Row(
              children: [
                Icon(icon, color: theme.colorScheme.primary),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: theme.textTheme.titleMedium),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(subtitle!, style: theme.textTheme.bodyMedium),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) trailing! else Icon(Icons.chevron_right, color: theme.colorScheme.onSurface.withValues(alpha: 0.4)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
