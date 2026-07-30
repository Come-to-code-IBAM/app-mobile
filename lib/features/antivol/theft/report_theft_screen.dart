import 'package:flutter/material.dart';

import '../../../core/app/app_scope.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/models/animal.dart';
import '../../../shared/widgets/section_header.dart';

/// Signaler une disparition : sélectionner l'animal puis décrire les circonstances.
class ReportTheftScreen extends StatefulWidget {
  const ReportTheftScreen({super.key});

  @override
  State<ReportTheftScreen> createState() => _ReportTheftScreenState();
}

class _ReportTheftScreenState extends State<ReportTheftScreen> {
  List<Animal> _animals = [];
  Animal? _selected;
  bool _loading = true;
  bool _saving = false;
  String? _error;

  final _location      = TextEditingController();
  final _circumstances = TextEditingController();

  @override
  void dispose() {
    _location.dispose();
    _circumstances.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loading) _loadAnimals();
  }

  Future<void> _loadAnimals() async {
    try {
      final repo = AppScope.of(context).animalRepository;
      final list = await repo.list();
      if (!mounted) return;
      setState(() {
        _animals = list.where((a) => a.status == AnimalStatus.active).toList();
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Impossible de charger le cheptel.';
      });
    }
  }

  Future<void> _confirm() async {
    if (_selected == null) {
      setState(() => _error = 'Sélectionnez un animal.');
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final repo = AppScope.of(context).animalRepository;
      await repo.reportStolen(_selected!.localUuid);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signalement enregistré. Sera transmis à la prochaine synchro.'),
        ),
      );
      Navigator.of(context).pop();
    } catch (e) {
      setState(() => _error = 'Erreur : $e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Signaler une disparition')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: AppSpacing.screen,
              children: [
                const SectionHeader(eyebrow: 'Animal', title: 'Lequel a disparu ?'),
                const SizedBox(height: AppSpacing.md),

                if (_animals.isEmpty)
                  Text(
                    'Aucun animal actif enrôlé.',
                    style: theme.textTheme.bodyMedium,
                  )
                else
                  ..._animals.map((animal) {
                    final isSelected = _selected?.localUuid == animal.localUuid;
                    final shortId = animal.publicId ??
                        'TRP-${animal.localUuid.replaceAll('-', '').substring(0, 8).toUpperCase()}';
                    return GestureDetector(
                      onTap: () => setState(() => _selected = animal),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.dangerLight
                              : theme.colorScheme.surface,
                          borderRadius: AppRadius.card,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.danger.withValues(alpha: 0.5)
                                : theme.dividerColor,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.pets_outlined,
                              color: isSelected
                                  ? AppColors.danger
                                  : theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${animal.species.name[0].toUpperCase()}${animal.species.name.substring(1)}'
                                    '${animal.breed != null ? ' — ${animal.breed}' : ''}',
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  Text(
                                    '$shortId · ${animal.ownerName}',
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              const Icon(Icons.check_circle, color: AppColors.danger),
                          ],
                        ),
                      ),
                    );
                  }),

                const SizedBox(height: AppSpacing.lg),
                const SectionHeader(title: 'Circonstances'),
                const SizedBox(height: AppSpacing.md),
                TextField(
                  controller: _location,
                  decoration: const InputDecoration(
                    labelText: 'Lieu',
                    hintText: 'Ex. pâturage de Loumbila',
                    prefixIcon: Icon(Icons.place_outlined),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                TextField(
                  controller: _circumstances,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Détails (optionnel)',
                    hintText: 'Décrivez ce qui s\'est passé',
                  ),
                ),

                if (_error != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    _error!,
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                ],

                const SizedBox(height: AppSpacing.md),
                _saving
                    ? const Center(child: CircularProgressIndicator())
                    : FilledButton.icon(
                        onPressed: _confirm,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.danger,
                        ),
                        icon: const Icon(Icons.report_outlined),
                        label: const Text('Confirmer le signalement'),
                      ),
                const SizedBox(height: AppSpacing.md),
              ],
            ),
    );
  }
}