import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../data/models/ration_result.dart';
import '../../core/app/app_scope.dart';
import '../../shared/widgets/section_header.dart';
import 'result_screen.dart';

/// Ration — étape 2 : aliments disponibles et prix.
class FeedsStepScreen extends StatefulWidget {
  const FeedsStepScreen({super.key, required this.herd});

  final Map<String, int> herd;

  @override
  State<FeedsStepScreen> createState() => _FeedsStepScreenState();
}

class _FeedsStepScreenState extends State<FeedsStepScreen> {
  final List<_FeedInput> _feeds = [
    _FeedInput(name: 'Tourteau de coton', selected: true, pricePerKg: 650),
    _FeedInput(name: 'Son de maïs', selected: true, pricePerKg: 250),
    _FeedInput(name: 'Fanes de niébé', selected: true, pricePerKg: 180),
    _FeedInput(name: 'Paille de sorgho', selected: false, pricePerKg: 120),
    _FeedInput(name: 'Bloc multinutritionnel', selected: false, pricePerKg: 800),
  ];

  bool _isComputing = false;

  Future<void> _computeRation(BuildContext context) async {
    setState(() => _isComputing = true);
    try {
      debugPrint('[_computeRation] starting compute');
      final repository = AppScope.of(context).rationRepository;
      final result = await repository.compute(
        herd: widget.herd.map((key, value) => MapEntry(key, value)),
        feeds: _feeds
            .where((feed) => feed.selected)
            .map((feed) => {
                  'name': feed.name,
                  'pricePerKg': feed.pricePerKg,
                  'selected': true,
                })
            .toList(),
      );
      debugPrint('[_computeRation] compute finished: totalCost=${result.totalCost}');
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => RationResultScreen(result: result)),
      );
    } catch (e, st) {
      debugPrint('[_computeRation] error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors du calcul: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isComputing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ration — 2/3 Aliments')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          const SectionHeader(eyebrow: 'Étape 2', title: 'Aliments disponibles'),
          const SizedBox(height: AppSpacing.md),
          ..._feeds.map((feed) => _FeedRow(
                feed: feed,
                onChanged: (updated) => setState(() => feed.selected = updated),
                onPriceChanged: (price) => setState(() => feed.pricePerKg = price),
              )),
          const SizedBox(height: AppSpacing.md),
          FilledButton.icon(
            onPressed: _isComputing ? null : () => _computeRation(context),
            icon: const Icon(Icons.calculate_outlined),
            label: Text(_isComputing ? 'Calcul…' : 'Calculer la ration'),
          ),
        ],
      ),
    );
  }
}

class _FeedRow extends StatelessWidget {
  const _FeedRow({required this.feed, required this.onChanged, required this.onPriceChanged});
  final _FeedInput feed;
  final ValueChanged<bool> onChanged;
  final ValueChanged<double> onPriceChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          Checkbox(value: feed.selected, onChanged: (value) => onChanged(value ?? false)),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: Text(feed.name, style: theme.textTheme.titleMedium)),
          SizedBox(
            width: 96,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: feed.pricePerKg.toString()),
              onChanged: (value) => onPriceChanged(double.tryParse(value) ?? 0),
              decoration: const InputDecoration(hintText: 'FCFA/kg', isDense: true),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedInput {
  _FeedInput({required this.name, required this.selected, required this.pricePerKg});

  final String name;
  bool selected;
  double pricePerKg;
}
