import 'package:fakto_mobile/app/fakto_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders MOV-13 and animates MOV-14 without changing totals', (
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
    expect(find.byKey(const Key('capture-menu-overlay')), findsNothing);

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

    expect(find.byKey(const Key('capture-menu-overlay')), findsOneWidget);
    expect(find.text('Grabar audio'), findsOneWidget);
    expect(find.text('Tomar foto'), findsOneWidget);

    final scrimTransition = find.byKey(
      const Key('capture-menu-scrim-transition'),
    );
    expect(tester.widget<FadeTransition>(scrimTransition).opacity.value, 0);

    await tester.pump(const Duration(milliseconds: 150));
    final enteringOpacity = tester
        .widget<FadeTransition>(scrimTransition)
        .opacity
        .value;
    expect(enteringOpacity, greaterThan(0));
    expect(enteringOpacity, lessThan(1));

    await tester.pumpAndSettle();

    expect(tester.widget<FadeTransition>(scrimTransition).opacity.value, 1);
    expect(find.text('Pendiente'), findsOneWidget);
    expect(find.text('Pagado'), findsOneWidget);
    expect(find.text(r'$ 1.250.000'), findsNWidgets(2));
    expect(find.text(r'$ 0'), findsOneWidget);
    expect(find.text(r'$ 450.000'), findsOneWidget);
    expect(find.text(r'$ 800.000'), findsOneWidget);

    final audioIcon = find.byKey(const Key('record-audio-icon'));
    final photoIcon = find.byKey(const Key('take-photo-icon'));
    final closeButton = find.byKey(const Key('close-capture-menu-button'));

    expect(tester.getSize(audioIcon), const Size.square(56));
    expect(tester.getSize(photoIcon), const Size.square(56));
    expect(tester.getSize(closeButton), const Size.square(56));
    expect(
      tester.getTopLeft(photoIcon).dy - tester.getTopLeft(audioIcon).dy,
      72,
    );
    expect(
      tester.getTopLeft(closeButton).dy - tester.getTopLeft(audioIcon).dy,
      128,
    );

    await tester.tap(closeButton);
    await tester.pump();

    expect(find.byKey(const Key('capture-menu-overlay')), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byKey(const Key('capture-menu-overlay')), findsNothing);
    expect(find.text('Grabar audio'), findsNothing);
    expect(find.text(r'$ 1.250.000'), findsNWidgets(2));
    expect(find.text(r'$ 0'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
