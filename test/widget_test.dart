import 'package:flutter_test/flutter_test.dart';

import 'package:carnet_troupeau/app.dart';

void main() {
  testWidgets('L\'app démarre sur le splash', (tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('Carnet numérique du troupeau'), findsWidgets);
  });
}
