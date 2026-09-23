import 'package:fakto_mobile/features/reminders/application/fakto_app_state.dart';
import 'package:fakto_mobile/features/reminders/domain/reminder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('starts with the monthly values from the home mockup', () {
    final appState = FaktoAppState();

    expect(appState.monthlySummary.totalCents, 125000000);
    expect(appState.monthlySummary.pendingCents, 80000000);
    expect(appState.monthlySummary.paidCents, 45000000);
    expect(appState.monthlySummary.carriedOverCents, 12000000);
  });

  test(
    'sets the selected photo batch exactly once and updates the summary',
    () {
      final appState = FaktoAppState();
      final initialSummary = appState.monthlySummary;

      final selectedBatch = appState.selectNextBatch(CaptureSource.photo);

      expect(selectedBatch.id, 'photo-1');
      expect(appState.confirmSelectedBatch(), isTrue);
      expect(appState.confirmSelectedBatch(), isFalse);
      expect(appState.monthlySummary.totalCents, 205000000);
      expect(appState.monthlySummary.pendingCents, 160000000);
      expect(appState.capturedReminder?.issuer, 'EPM');
      expect(
        appState.monthlySummary.totalCents,
        greaterThan(initialSummary.totalCents),
      );
    },
  );

  test('cycles through two audio batches after each confirmed capture', () {
    final appState = FaktoAppState();

    expect(appState.selectNextBatch(CaptureSource.audio).id, 'audio-1');
    appState.confirmSelectedBatch();
    expect(appState.selectNextBatch(CaptureSource.audio).id, 'audio-2');
    appState.confirmSelectedBatch();
    expect(appState.selectNextBatch(CaptureSource.audio).id, 'audio-1');
  });

  test(
    'replaces the captured card instead of accumulating previous captures',
    () {
      final appState = FaktoAppState();

      appState.selectNextBatch(CaptureSource.photo);
      appState.confirmSelectedBatch();
      appState.selectNextBatch(CaptureSource.audio);
      appState.confirmSelectedBatch();

      expect(appState.capturedReminder?.issuer, 'Internet');
      expect(appState.monthlySummary.totalCents, 137000000);
      expect(appState.monthlySummary.pendingCents, 92000000);
    },
  );
}
