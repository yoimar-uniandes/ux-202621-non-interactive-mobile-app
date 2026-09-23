enum CaptureSource { photo, audio }

class Reminder {
  const Reminder({
    required this.id,
    required this.issuer,
    required this.concept,
    required this.amountCents,
    required this.dueDate,
    required this.source,
    this.isPaid = false,
  });

  final String id;
  final String issuer;
  final String concept;
  final int amountCents;
  final DateTime dueDate;
  final CaptureSource source;
  final bool isPaid;

  Reminder withId(String id) => Reminder(
    id: id,
    issuer: issuer,
    concept: concept,
    amountCents: amountCents,
    dueDate: dueDate,
    source: source,
    isPaid: isPaid,
  );
}

class CaptureBatch {
  const CaptureBatch({
    required this.id,
    required this.source,
    required this.reminders,
    required this.sourceReference,
  });

  final String id;
  final CaptureSource source;
  final List<Reminder> reminders;
  final String sourceReference;
}

class MonthlySummary {
  const MonthlySummary({
    required this.totalCents,
    required this.pendingCents,
    required this.paidCents,
    required this.carriedOverCents,
  });

  final int totalCents;
  final int pendingCents;
  final int paidCents;
  final int carriedOverCents;
}

String formatPesos(int amountCents) {
  final amount = (amountCents / 100).round().toString();
  final separated = amount.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (match) => '.',
  );

  return r'$ ' + separated;
}
