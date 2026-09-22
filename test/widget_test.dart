import 'package:fakto_mobile/app/fakto_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('keeps totals stable before confirmation and reaches MOV-24 from the capture menu', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const FaktoApp());

    expect(find.byKey(const Key('camera-capture-page')), findsNothing);
    expect(find.text(r'$ 1.250.000'), findsNWidgets(2));
    expect(find.text(r'$ 0'), findsOneWidget);

    await tester.tap(find.byKey(const Key('add-reminder-button')));
    await tester.pumpAndSettle();

    expect(find.text('Grabar audio'), findsOneWidget);
    expect(find.text('Tomar foto'), findsOneWidget);
    expect(find.text(r'$ 1.250.000'), findsNWidgets(2));
    expect(find.text(r'$ 0'), findsOneWidget);

    await tester.tap(find.byKey(const Key('take-photo-option')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('camera-capture-page')), findsOneWidget);
    expect(find.text('Encuadra la factura dentro del marco'), findsOneWidget);
    expect(find.byKey(const Key('camera-close-button')), findsOneWidget);
    expect(
      tester.getSize(find.byKey(const Key('camera-shutter-button'))),
      const Size.square(72),
    );

    await tester.tap(find.byKey(const Key('camera-shutter-button')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('read-photo-card')), findsOneWidget);
    expect(find.text('Revisa lo que leímos'), findsOneWidget);
    expect(find.text('factura-epm-septiembre.jpg'), findsOneWidget);

    await tester.tap(find.byKey(const Key('read-summary-close-button')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('camera-capture-page')), findsNothing);
    expect(find.text('Hola, Claudia'), findsOneWidget);

    await tester.tap(find.byKey(const Key('add-reminder-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('record-audio-option')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('audio-capture-page')), findsOneWidget);
    expect(find.text('Grabando...'), findsOneWidget);
    expect(find.text('00:12'), findsOneWidget);
    expect(find.text('Di el emisor, el valor y la fecha límite.'), findsOneWidget);
    expect(find.byKey(const Key('audio-stop-button')), findsOneWidget);

    await tester.tap(find.byKey(const Key('audio-stop-button')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('audio-capture-page')), findsNothing);
    expect(find.byKey(const Key('read-audio-card')), findsOneWidget);
    expect(find.text('Nota de voz · 00:12 · grabada hoy'), findsOneWidget);
    expect(
      find.text('«EPM, ochocientos mil pesos, vence el veintiocho de septiembre.»'),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const Key('corregir-read-summary-button')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('audio-capture-page')), findsOneWidget);
    expect(find.byKey(const Key('camera-capture-page')), findsNothing);

    await tester.tap(find.byKey(const Key('audio-close-button')));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
