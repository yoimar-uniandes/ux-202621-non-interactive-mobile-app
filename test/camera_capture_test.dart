import 'package:fakto_mobile/app/fakto_app_scope.dart';
import 'package:fakto_mobile/design/app_theme.dart';
import 'package:fakto_mobile/features/capture/presentation/camera_capture_page.dart';
import 'package:fakto_mobile/features/capture/presentation/read_summary_page.dart';
import 'package:fakto_mobile/features/home/presentation/home_page.dart';
import 'package:fakto_mobile/features/reminders/application/fakto_app_state.dart';
import 'package:fakto_mobile/features/reminders/domain/reminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets(
    'selects the next photo batch without updating the home summary',
    (tester) async {
      final appState = FaktoAppState();
      final router = _buildRouter();
      addTearDown(router.dispose);

      await tester.pumpWidget(_app(appState, router));

      await tester.tap(find.byKey(const Key('camera-shutter-button')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('read-photo-card')), findsOneWidget);
      expect(appState.selectedBatch?.id, 'photo-1');
      expect(appState.selectedBatch?.source, CaptureSource.photo);
      expect(appState.monthlySummary.totalCents, 125000000);
      expect(appState.capturedReminder, isNull);
    },
  );

  testWidgets('discards a pending batch when closing the camera', (
    tester,
  ) async {
    final appState = FaktoAppState()..selectNextBatch(CaptureSource.photo);
    final router = _buildRouter();
    addTearDown(router.dispose);

    await tester.pumpWidget(_app(appState, router));
    await tester.tap(find.byKey(const Key('camera-close-button')));
    await tester.pumpAndSettle();

    expect(find.text('Hola, Claudia'), findsOneWidget);
    expect(appState.selectedBatch, isNull);
    expect(appState.monthlySummary.totalCents, 125000000);
  });
}

Widget _app(FaktoAppState appState, GoRouter router) => FaktoAppScope(
  notifier: appState,
  child: MaterialApp.router(theme: buildAppTheme(), routerConfig: router),
);

GoRouter _buildRouter() => GoRouter(
  initialLocation: CameraCapturePage.routePath,
  routes: <RouteBase>[
    GoRoute(
      path: HomePage.routePath,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: CameraCapturePage.routePath,
      builder: (context, state) => const CameraCapturePage(),
    ),
    GoRoute(
      path: ReadSummaryPage.routePath,
      builder: (context, state) => const ReadSummaryPage(),
    ),
  ],
);
