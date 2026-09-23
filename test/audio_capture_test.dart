import 'package:fakto_mobile/app/fakto_app_scope.dart';
import 'package:fakto_mobile/design/app_theme.dart';
import 'package:fakto_mobile/features/capture/presentation/audio_capture_page.dart';
import 'package:fakto_mobile/features/capture/presentation/read_summary_page.dart';
import 'package:fakto_mobile/features/home/presentation/home_page.dart';
import 'package:fakto_mobile/features/reminders/application/fakto_app_state.dart';
import 'package:fakto_mobile/features/reminders/domain/reminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets(
    'selects the next audio batch without updating the home summary',
    (tester) async {
      final appState = FaktoAppState();
      final router = _buildRouter();
      addTearDown(router.dispose);

      await tester.pumpWidget(_app(appState, router));
      await tester.tap(find.byKey(const Key('audio-stop-button')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('read-audio-card')), findsOneWidget);
      expect(appState.selectedBatch?.id, 'audio-1');
      expect(appState.selectedBatch?.source, CaptureSource.audio);
      expect(appState.monthlySummary.totalCents, 125000000);
      expect(appState.capturedReminder, isNull);
    },
  );

  testWidgets('discards a pending audio batch when closing recording', (
    tester,
  ) async {
    final appState = FaktoAppState()..selectNextBatch(CaptureSource.audio);
    final router = _buildRouter();
    addTearDown(router.dispose);

    await tester.pumpWidget(_app(appState, router));
    await tester.tap(find.byKey(const Key('audio-close-button')));
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
  initialLocation: AudioCapturePage.routePath,
  routes: <RouteBase>[
    GoRoute(
      path: HomePage.routePath,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AudioCapturePage.routePath,
      builder: (context, state) => const AudioCapturePage(),
    ),
    GoRoute(
      path: ReadSummaryPage.routePath,
      builder: (context, state) => ReadSummaryPage(
        isFromAudio: state.uri.queryParameters['source'] == 'audio',
      ),
    ),
  ],
);
