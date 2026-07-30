import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/app/app_scope.dart';
import '../../../core/config/constants.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/models/animal.dart';
import '../../../shared/widgets/labeled_field.dart';
import '../../../shared/widgets/section_header.dart';
import 'enroll_success_screen.dart';

/// Étape 2 de l'enrôlement : renseigner l'animal et son propriétaire.
class EnrollFormScreen extends StatefulWidget {
  const EnrollFormScreen({super.key, this.muzzleImageBytes});

  final List<int>? muzzleImageBytes;

  @override
  State<EnrollFormScreen> createState() => _EnrollFormScreenState();
}

class _EnrollFormScreenState extends State<EnrollFormScreen> {
  final _ownerName   = TextEditingController();
  final _ownerPhone  = TextEditingController();
  final _village     = TextEditingController();
  final _breed       = TextEditingController();
  final _ageEstimate = TextEditingController();
  final _distinctive = TextEditingController();
  final _witnessName = TextEditingController();
  final _witnessPhone= TextEditingController();

  AnimalSpecies _species = AnimalSpecies.bovin;
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _ownerName.dispose();
    _ownerPhone.dispose();
    _village.dispose();
    _breed.dispose();
    _ageEstimate.dispose();
    _distinctive.dispose();
    _witnessName.dispose();
    _witnessPhone.dispose();
    super.dispose();
  }

  String _generateLocalUuid() {
    final rng = Random.secure();
    final bytes = List<int>.generate(16, (_) => rng.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    String hex(int b) => b.toRadixString(16).padLeft(2, '0');
    final s = bytes.map(hex).join();
    return '${s.substring(0,8)}-${s.substring(8,12)}-${s.substring(12,16)}-${s.substring(16,20)}-${s.substring(20)}';
  }

  Future<void> _save() async {
    if (_ownerName.text.trim().isEmpty || _ownerPhone.text.trim().isEmpty) {
      setState(() => _error = 'Le nom et le téléphone du propriétaire sont requis.');
      return;
    }
    setState(() { _saving = true; _error = null; });
    try {
      final repo = AppScope.of(context).animalRepository;
      final animal = Animal(
        localUuid:       _generateLocalUuid(),
        ownerName:       _ownerName.text.trim(),
        ownerPhone:      _ownerPhone.text.trim(),
        village:         _village.text.trim().isEmpty ? null : _village.text.trim(),
        species:         _species,
        breed:           _breed.text.trim().isEmpty ? null : _breed.text.trim(),
        ageEstimate:     int.tryParse(_ageEstimate.text.trim()),
        distinctiveSign: _distinctive.text.trim().isEmpty ? null : _distinctive.text.trim(),
        witnessName:     _witnessName.text.trim().isEmpty ? null : _witnessName.text.trim(),
        witnessPhone:    _witnessPhone.text.trim().isEmpty ? null : _witnessPhone.text.trim(),
        signatureBlob:   widget.muzzleImageBytes,
        syncPending:     true,
      );
      await repo.enroll(animal);
      if (!mounted) return;
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => EnrollSuccessScreen(localUuid: animal.localUuid),
        ),
      );
    } catch (e) {
      setState(() => _error = 'Erreur lors de l\'enregistrement : $e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enrôler — informations')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          const SectionHeader(eyebrow: 'Propriétaire', title: 'Éleveur'),
          const SizedBox(height: AppSpacing.md),
          LabeledField(
            label: 'Nom du propriétaire',
            hint: 'Ex. Issa Koné',
            prefixIcon: Icons.person_outline,
            controller: _ownerName,
          ),
          LabeledField(
            label: 'Téléphone',
            hint: '70 00 00 00',
            keyboardType: TextInputType.phone,
            prefixIcon: Icons.phone_outlined,
            controller: _ownerPhone,
          ),
          LabeledField(
            label: 'Village',
            hint: 'Ex. Loumbila',
            prefixIcon: Icons.place_outlined,
            controller: _village,
          ),
          const SizedBox(height: AppSpacing.sm),
          const SectionHeader(eyebrow: 'Animal', title: 'Caractéristiques'),
          const SizedBox(height: AppSpacing.md),
          DropdownButtonFormField<AnimalSpecies>(
            value: _species,
            decoration: const InputDecoration(labelText: 'Espèce'),
            items: AnimalSpecies.values.map((s) {
              final label = s.name[0].toUpperCase() + s.name.substring(1);
              return DropdownMenuItem(value: s, child: Text(label));
            }).toList(),
            onChanged: (v) { if (v != null) setState(() => _species = v); },
          ),
          const SizedBox(height: AppSpacing.sm),
          LabeledField(
            label: 'Race',
            hint: 'Ex. Zébu',
            optional: true,
            controller: _breed,
          ),
          LabeledField(
            label: 'Âge estimé (années)',
            hint: 'Ex. 3',
            keyboardType: TextInputType.number,
            optional: true,
            controller: _ageEstimate,
          ),
          LabeledField(
            label: 'Signe distinctif',
            hint: 'Ex. corne gauche cassée',
            optional: true,
            controller: _distinctive,
          ),
          const SizedBox(height: AppSpacing.sm),
          const SectionHeader(eyebrow: 'Témoin', title: 'Optionnel'),
          const SizedBox(height: AppSpacing.md),
          LabeledField(
            label: 'Nom du témoin',
            hint: 'Ex. Chef de village',
            optional: true,
            controller: _witnessName,
          ),
          LabeledField(
            label: 'Téléphone du témoin',
            keyboardType: TextInputType.phone,
            optional: true,
            controller: _witnessPhone,
          ),
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ],
          const SizedBox(height: AppSpacing.md),
          _saving
              ? const Center(child: CircularProgressIndicator())
              : FilledButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.check),
                  label: const Text('Enregistrer l\'animal'),
                ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}