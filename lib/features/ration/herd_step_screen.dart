import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/section_header.dart';
import 'feeds_step_screen.dart';

/// Ration — étape 1 : composition du troupeau à nourrir.
class HerdStepScreen extends StatefulWidget {
  const HerdStepScreen({super.key});

  @override
  State<HerdStepScreen> createState() => _HerdStepScreenState();
}

class _HerdStepScreenState extends State<HerdStepScreen> {
  final Map<String, int> _herd = {
    'maintenance': 6,
    'pregnant': 2,
    'growth': 4,
    'lactation': 3,
  };

  void _update(String key, int delta) {
    setState(() {
      _herd[key] = (_herd[key] ?? 0) + delta;
      if (_herd[key]! < 0) {
        _herd[key] = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ration — 1/3 Troupeau')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          const SectionHeader(eyebrow: 'Étape 1', title: 'Mon troupeau'),
          const SizedBox(height: AppSpacing.md),
          _CounterRow(
            label: 'Vaches en entretien',
            value: _herd['maintenance'] ?? 0,
            onChanged: (delta) => _update('maintenance', delta),
          ),
          _CounterRow(
            label: 'Vaches gestantes',
            value: _herd['pregnant'] ?? 0,
            onChanged: (delta) => _update('pregnant', delta),
          ),
          _CounterRow(
            label: 'Jeunes en croissance',
            value: _herd['growth'] ?? 0,
            onChanged: (delta) => _update('growth', delta),
          ),
          _CounterRow(
            label: 'Vaches en lactation',
            value: _herd['lactation'] ?? 0,
            onChanged: (delta) => _update('lactation', delta),
          ),
          const SizedBox(height: AppSpacing.md),
          FilledButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => FeedsStepScreen(herd: _herd),
              ),
            ),
            child: const Text('Continuer'),
          ),
        ],
      ),
    );
  }
}

class _CounterRow extends StatelessWidget {
  const _CounterRow({required this.label, required this.value, required this.onChanged});
  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          Expanded(child: Text(label, style: theme.textTheme.titleMedium)),
          IconButton(onPressed: () => onChanged(-1), icon: const Icon(Icons.remove_circle_outline)),
          Text('$value', style: theme.textTheme.titleLarge),
          IconButton(onPressed: () => onChanged(1), icon: const Icon(Icons.add_circle_outline)),
        ],
      ),
    );
  }
}
