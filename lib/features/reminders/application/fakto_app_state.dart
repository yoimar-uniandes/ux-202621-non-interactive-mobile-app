import 'package:fakto_mobile/features/reminders/domain/reminder.dart';
import 'package:flutter/foundation.dart';

class FaktoAppState extends ChangeNotifier {
  FaktoAppState();

  static const _carriedOverCents = 12000000;

  static final List<Reminder> _initialReminders = <Reminder>[
    Reminder(
      id: 'initial-epm',
      issuer: 'EPM',
      concept: 'Servicio público',
      amountCents: 80000000,
      dueDate: DateTime(2026, 9, 23),
      source: CaptureSource.photo,
    ),
    Reminder(
      id: 'initial-administration',
      issuer: 'Administración',
      concept: 'Administración',
      amountCents: 45000000,
      dueDate: DateTime(2026, 9, 24),
      source: CaptureSource.audio,
      isPaid: true,
    ),
  ];

  static final Map<CaptureSource, List<CaptureBatch>> _batchesBySource =
      <CaptureSource, List<CaptureBatch>>{
        CaptureSource.photo: <CaptureBatch>[
          CaptureBatch(
            id: 'photo-1',
            source: CaptureSource.photo,
            sourceReference: 'factura-epm-septiembre.jpg',
            reminders: <Reminder>[
              Reminder(
                id: 'photo-1-invoice-1',
                issuer: 'EPM',
                concept: 'Servicio público',
                amountCents: 80000000,
                dueDate: DateTime(2026, 9, 28),
                source: CaptureSource.photo,
              ),
            ],
          ),
          CaptureBatch(
            id: 'photo-2',
            source: CaptureSource.photo,
            sourceReference: 'factura-acueducto-septiembre.jpg',
            reminders: <Reminder>[
              Reminder(
                id: 'photo-2-invoice-1',
                issuer: 'Acueducto',
                concept: 'Servicio público',
                amountCents: 18000000,
                dueDate: DateTime(2026, 9, 30),
                source: CaptureSource.photo,
              ),
            ],
          ),
        ],
        CaptureSource.audio: <CaptureBatch>[
          CaptureBatch(
            id: 'audio-1',
            source: CaptureSource.audio,
            sourceReference:
                '«Internet hogar, ciento veinte mil pesos, vence el dos de octubre.»',
            reminders: <Reminder>[
              Reminder(
                id: 'audio-1-invoice-1',
                issuer: 'Internet',
                concept: 'Internet hogar',
                amountCents: 12000000,
                dueDate: DateTime(2026, 10, 2),
                source: CaptureSource.audio,
              ),
            ],
          ),
          CaptureBatch(
            id: 'audio-2',
            source: CaptureSource.audio,
            sourceReference:
                '«Gas natural, noventa y cinco mil pesos, vence el cinco de octubre.»',
            reminders: <Reminder>[
              Reminder(
                id: 'audio-2-invoice-1',
                issuer: 'Gas natural',
                concept: 'Servicio público',
                amountCents: 9500000,
                dueDate: DateTime(2026, 10, 5),
                source: CaptureSource.audio,
              ),
            ],
          ),
        ],
      };

  final Map<CaptureSource, int> _nextBatchIndex = <CaptureSource, int>{
    CaptureSource.photo: 0,
    CaptureSource.audio: 0,
  };

  CaptureBatch? _selectedBatch;
  Reminder? _capturedReminder;
  int _confirmationNumber = 0;

  CaptureBatch? get selectedBatch => _selectedBatch;

  Reminder? get capturedReminder => _capturedReminder;

  MonthlySummary get monthlySummary {
    final reminders = <Reminder>[..._initialReminders, ?_capturedReminder];
    final totalCents = reminders.fold<int>(
      0,
      (total, reminder) => total + reminder.amountCents,
    );
    final paidCents = reminders
        .where((reminder) => reminder.isPaid)
        .fold<int>(0, (total, reminder) => total + reminder.amountCents);

    return MonthlySummary(
      totalCents: totalCents,
      pendingCents: totalCents - paidCents,
      paidCents: paidCents,
      carriedOverCents: _carriedOverCents,
    );
  }

  CaptureBatch selectNextBatch(CaptureSource source) {
    final batches = _batchesBySource[source]!;
    final batchIndex = _nextBatchIndex[source]! % batches.length;
    final batch = batches[batchIndex];

    _selectedBatch = batch;
    notifyListeners();
    return batch;
  }

  bool confirmSelectedBatch() {
    final batch = _selectedBatch;
    if (batch == null) return false;

    _confirmationNumber += 1;
    _capturedReminder = batch.reminders.single.withId(
      '${batch.id}-$_confirmationNumber',
    );
    _nextBatchIndex[batch.source] = _nextBatchIndex[batch.source]! + 1;
    _selectedBatch = null;
    notifyListeners();
    return true;
  }

  void discardSelectedBatch() {
    if (_selectedBatch == null) return;

    _selectedBatch = null;
    notifyListeners();
  }
}
