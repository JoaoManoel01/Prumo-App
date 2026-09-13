import 'package:flutter_test/flutter_test.dart';

import 'package:prumo/main.dart';

void main() {
  testWidgets('mostra a tela de orçamentos', (WidgetTester tester) async {
    await tester.pumpWidget(const PrumoApp());

    expect(find.text('ORÇAMENTOS'), findsOneWidget);
    expect(find.text('Olá, Carlos'), findsOneWidget);
  });
}
