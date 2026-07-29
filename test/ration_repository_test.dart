import 'package:flutter_test/flutter_test.dart';
import 'package:carnet_troupeau/data/repositories/ration_repository.dart';

void main() {
  test('compute builds a ration result from herd and feed inputs', () async {
    final repository = RationRepository();

    final result = await repository.compute(
      herd: {
        'maintenance': 6,
        'pregnant': 2,
        'growth': 4,
        'lactation': 3,
      },
      feeds: [
        {'name': 'Tourteau de coton', 'pricePerKg': 650.0, 'selected': true},
        {'name': 'Son de maïs', 'pricePerKg': 250.0, 'selected': true},
        {'name': 'Fanes de niébé', 'pricePerKg': 180.0, 'selected': true},
      ],
    );

    expect(result.totalCost, greaterThan(0.0));
    expect(result.mixResult, isNotEmpty);
    expect(result.availableFeeds, isNotEmpty);
  });
}
