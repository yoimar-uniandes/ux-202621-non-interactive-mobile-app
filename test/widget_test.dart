import 'package:fakto_mobile/app/fakto_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders MOV-13 at the 360 x 800 design viewport', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const FaktoApp());

    expect(find.text('Hola, Claudia'), findsOneWidget);
    expect(find.text('Total del mes'), findsOneWidget);
    expect(find.text('Recordatorios'), findsOneWidget);
    expect(find.text('EPM'), findsOneWidget);
    expect(find.text('Administración'), findsOneWidget);
    expect(find.text('Añadir'), findsOneWidget);

    expect(
      tester.getSize(find.byKey(const Key('monthly-summary-card'))),
      const Size(328, 208),
    );
    expect(
      tester.getSize(find.byKey(const Key('epm-reminder-card'))),
      const Size(328, 108),
    );
    expect(
      tester.getSize(find.byKey(const Key('bottom-navigation'))),
      const Size(360, 80),
    );

    await tester.tap(find.byKey(const Key('add-reminder-button')));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}
