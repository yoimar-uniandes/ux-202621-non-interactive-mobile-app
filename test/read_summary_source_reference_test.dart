import 'package:fakto_mobile/app/fakto_app_scope.dart';
import 'package:fakto_mobile/design/app_theme.dart';
import 'package:fakto_mobile/features/capture/presentation/read_summary_page.dart';
import 'package:fakto_mobile/features/reminders/application/fakto_app_state.dart';
import 'package:fakto_mobile/features/reminders/domain/reminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('uses the source reference of each selected dummy batch', (
    tester,
  ) async {
    final photoState = FaktoAppState()..selectNextBatch(CaptureSource.photo);
    photoState.confirmSelectedBatch();
    photoState.selectNextBatch(CaptureSource.photo);

    await tester.pumpWidget(_app(photoState, const ReadSummaryPage()));

    expect(find.text('factura-acueducto-septiembre.jpg'), findsOneWidget);
    expect(find.text('Acueducto'), findsOneWidget);

    final audioState = FaktoAppState();
    audioState.selectNextBatch(CaptureSource.audio);
    audioState.confirmSelectedBatch();
    audioState.selectNextBatch(CaptureSource.audio);

    await tester.pumpWidget(
      _app(audioState, const ReadSummaryPage(isFromAudio: true)),
    );

    expect(
      find.text(
        '«Gas natural, noventa y cinco mil pesos, vence el cinco de octubre.»',
      ),
      findsOneWidget,
    );
    expect(find.text('Gas natural'), findsOneWidget);
  });
}

Widget _app(FaktoAppState appState, Widget child) => FaktoAppScope(
  notifier: appState,
  child: MaterialApp(theme: buildAppTheme(), home: child),
);
