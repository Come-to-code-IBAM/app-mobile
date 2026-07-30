import 'package:flutter/material.dart';

import '../../../core/app/app_scope.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/models/animal.dart';
import '../../../shared/widgets/animal_list_tile.dart';
import '../../../shared/widgets/status_badge.dart';
import '../animal_detail_screen.dart';
import '../enroll/enroll_capture_screen.dart';

/// Liste des animaux enrôlés (le cheptel de l'utilisateur).
class HerdListScreen extends StatefulWidget {
  const HerdListScreen({super.key});

  @override
  State<HerdListScreen> createState() => _HerdListScreenState();
}

class _HerdListScreenState extends State<HerdListScreen> {
  List<Animal> _animals = [];
  bool _loading = true;
  String? _error;

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
        _animals = list;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Impossible de charger le cheptel : $e';
      });
    }
  }

  Future<void> _refresh() async {
    setState(() => _loading = true);
    await _loadAnimals();
  }

  BadgeStatus _toBadgeStatus(AnimalStatus status) {
    return switch (status) {
      AnimalStatus.active      => BadgeStatus.active,
      AnimalStatus.stolen      => BadgeStatus.stolen,
      AnimalStatus.transferred => BadgeStatus.active,
      AnimalStatus.dead        => BadgeStatus.stolen,
    };
  }

  String _statusLabel(AnimalStatus status) {
    return switch (status) {
      AnimalStatus.active      => 'Actif',
      AnimalStatus.stolen      => 'Volé',
      AnimalStatus.transferred => 'Transféré',
      AnimalStatus.dead        => 'Décédé',
    };
  }

  String _animalName(Animal a) {
    final species = a.species.name[0].toUpperCase() + a.species.name.substring(1);
    if (a.breed != null) return '$species — ${a.breed}';
    return species;
  }

  String _animalSubtitle(Animal a) {
    final shortId = a.publicId ??
        'TRP-${a.localUuid.replaceAll('-', '').substring(0, 8).toUpperCase()}';
    final age = a.ageEstimate != null ? ' · ${a.ageEstimate} ans' : '';
    return '$shortId$age';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mon cheptel')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_error!, textAlign: TextAlign.center),
                      const SizedBox(height: AppSpacing.md),
                      OutlinedButton(
                        onPressed: _refresh,
                        child: const Text('Réessayer'),
                      ),
                    ],
                  ),
                )
              : _animals.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.pets_outlined, size: 48),
                          const SizedBox(height: AppSpacing.md),
                          const Text('Aucun animal enrôlé pour l\'instant.'),
                          const SizedBox(height: AppSpacing.md),
                          FilledButton.icon(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const EnrollCaptureScreen(),
                              ),
                            ),
                            icon: const Icon(Icons.add),
                            label: const Text('Enrôler un animal'),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView.separated(
                        padding: AppSpacing.screen,
                        itemCount: _animals.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: AppSpacing.sm),
                        itemBuilder: (context, i) {
                          final animal = _animals[i];
                          return AnimalListTile(
                            name: _animalName(animal),
                            subtitle: _animalSubtitle(animal),
                            status: _toBadgeStatus(animal.status),
                            statusLabel: _statusLabel(animal.status),
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => AnimalDetailScreen(
                                  name: _animalName(animal),
                                  status: _toBadgeStatus(animal.status),
                                  statusLabel: _statusLabel(animal.status),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const EnrollCaptureScreen()),
          );
          // Rafraîchir la liste après un éventuel enrôlement.
          _refresh();
        },
        icon: const Icon(Icons.add),
        label: const Text('Enrôler'),
      ),
    );
  }
}