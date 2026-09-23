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

  testWidgets('confirms the selected photo and updates the home summary', (

    tester,

  ) async {

    await tester.binding.setSurfaceSize(const Size(360, 800));

    addTearDown(() => tester.binding.setSurfaceSize(null));



    final appState = FaktoAppState()..selectNextBatch(CaptureSource.photo);

    final router = _buildRouter();

    addTearDown(router.dispose);



    await tester.pumpWidget(_app(appState, router));



    expect(find.text('EPM'), findsOneWidget);

    expect(find.text(r'$ 800.000'), findsOneWidget);

    expect(find.text('28/09/2026'), findsOneWidget);



    final confirmButton = find.byKey(const Key('confirmar-read-summary-button'));

    await tester.ensureVisible(confirmButton);

    await tester.tap(confirmButton);

    await tester.pumpAndSettle();



    expect(find.text('Hola, Claudia'), findsOneWidget);

    expect(find.byKey(const Key('captured-reminder-card')), findsOneWidget);

    expect(find.text(r'$ 2.050.000'), findsOneWidget);

    expect(appState.selectedBatch, isNull);

    expect(appState.capturedReminder?.issuer, 'EPM');

  });



  testWidgets('correct returns to camera without confirming the photo batch', (

    tester,

  ) async {

    await tester.binding.setSurfaceSize(const Size(360, 800));

    addTearDown(() => tester.binding.setSurfaceSize(null));



    final appState = FaktoAppState()..selectNextBatch(CaptureSource.photo);

    final router = _buildRouter();

    addTearDown(router.dispose);



    await tester.pumpWidget(_app(appState, router));

    final correctButton = find.byKey(const Key('corregir-read-summary-button'));

    await tester.ensureVisible(correctButton);

    await tester.tap(correctButton);

    await tester.pumpAndSettle();



    expect(find.byKey(const Key('camera-capture-page')), findsOneWidget);

    expect(appState.selectedBatch?.id, 'photo-1');

    expect(appState.capturedReminder, isNull);

    expect(appState.monthlySummary.totalCents, 125000000);

  });



  testWidgets('close discards the photo batch without updating home', (

    tester,

  ) async {

    await tester.binding.setSurfaceSize(const Size(360, 800));

    addTearDown(() => tester.binding.setSurfaceSize(null));



    final appState = FaktoAppState()..selectNextBatch(CaptureSource.photo);

    final router = _buildRouter();

    addTearDown(router.dispose);



    await tester.pumpWidget(_app(appState, router));

    await tester.binding.handlePopRoute();

    await tester.pumpAndSettle();



    expect(find.text('Hola, Claudia'), findsOneWidget);

    expect(appState.selectedBatch, isNull);

    expect(appState.capturedReminder, isNull);

    expect(appState.monthlySummary.totalCents, 125000000);

  });

}



Widget _app(FaktoAppState appState, GoRouter router) => FaktoAppScope(

  notifier: appState,

  child: MaterialApp.router(theme: buildAppTheme(), routerConfig: router),

);


GoRouter _buildRouter() => GoRouter(

  initialLocation: ReadSummaryPage.routePath,

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
