import 'package:fakto_mobile/app/fakto_app.dart';
import 'package:fakto_mobile/app/fakto_app_scope.dart';
import 'package:fakto_mobile/design/app_theme.dart';
import 'package:fakto_mobile/features/home/presentation/home_page.dart';
import 'package:fakto_mobile/features/reminders/application/fakto_app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('closes the capture menu on Android back without mutating data', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final appState = FaktoAppState();
    await tester.pumpWidget(
      FaktoAppScope(
        notifier: appState,
        child: MaterialApp(theme: buildAppTheme(), home: const HomePage()),
      ),
    );

    await tester.tap(find.byKey(const Key('add-reminder-button')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('capture-menu-overlay')), findsOneWidget);
    expect(appState.selectedBatch, isNull);
    expect(appState.capturedReminder, isNull);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('capture-menu-overlay')), findsNothing);
    expect(appState.selectedBatch, isNull);
    expect(appState.capturedReminder, isNull);
    expect(appState.monthlySummary.totalCents, 125000000);
    expect(appState.monthlySummary.pendingCents, 80000000);
  });

  testWidgets('keeps the full capture-option row tappable', (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const FaktoApp());

    await tester.tap(find.byKey(const Key('add-reminder-button')));
    await tester.pumpAndSettle();

    final audioOption = tester.getRect(
      find.byKey(const Key('record-audio-option')),
    );
    expect(audioOption.right, 360);

    await tester.tapAt(Offset(audioOption.right - 4, audioOption.center.dy));
    await tester.pumpAndSettle();

    expect(find.text('Grabando...'), findsOneWidget);
  });
}
