import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../core/app/app_scope.dart';
import '../../data/models/ration_result.dart';
import 'history_detail_screen.dart';

/// Historique des rations calculées.
class RationHistoryScreen extends StatefulWidget {
  const RationHistoryScreen({super.key});

  @override
  State<RationHistoryScreen> createState() => _RationHistoryScreenState();
}

class _RationHistoryScreenState extends State<RationHistoryScreen> {
  late Future<List<RationResult>> _historyFuture;
  bool _historyLoaded = false;

  @override
  void initState() {
    super.initState();
    _historyFuture = Future.value(<RationResult>[]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_historyLoaded) {
      _historyLoaded = true;
      _historyFuture = _loadHistory();
    }
  }

  Future<List<RationResult>> _loadHistory() async {
    final repository = AppScope.of(context).rationRepository;
    final history = await repository.history();
    debugPrint('[RationHistoryScreen] loaded ${history.length} history items');
    return history;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique des rations'),
        centerTitle: false,
      ),
      body: FutureBuilder<List<RationResult>>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            final error = snapshot.error;
            debugPrint('[RationHistoryScreen] history error: $error');
            return Center(
              child: Padding(
                padding: AppSpacing.screen,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Impossible de charger l’historique.',
                      style: theme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      error.toString(),
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Padding(
                padding: AppSpacing.screen,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.grass_outlined, size: 48),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Aucune ration enregistrée pour le moment.',
                      style: theme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          final items = snapshot.data!;
          return ListView.separated(
            padding: AppSpacing.screen,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, i) {
              final item = items[i];
              final herdCount =
                  item.herdSnapshot.values.fold<int>(0, (sum, value) {
                if (value is num) {
                  return sum + value.toInt();
                }
                return sum;
              });
              return FilledButton(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.md, horizontal: AppSpacing.md),
                  backgroundColor: theme.colorScheme.surface,
                  foregroundColor: theme.colorScheme.onSurface,
                  shape: RoundedRectangleBorder(borderRadius: AppRadius.card),
                  alignment: Alignment.centerLeft,
                ),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => RationHistoryDetailScreen(ration: item),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.grass_outlined,
                          color: theme.colorScheme.onPrimaryContainer),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.createdAt
                                .toLocal()
                                .toString()
                                .split(' ')
                                .first,
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '$herdCount têtes · ${item.totalCost.toStringAsFixed(0)} FCFA/jour',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right,
                        color: theme.colorScheme.onSurface.withOpacity(0.6)),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
