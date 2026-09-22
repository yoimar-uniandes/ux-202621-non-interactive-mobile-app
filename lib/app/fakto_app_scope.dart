import 'package:fakto_mobile/features/reminders/application/fakto_app_state.dart';
import 'package:flutter/widgets.dart';

class FaktoAppScope extends InheritedNotifier<FaktoAppState> {
  const FaktoAppScope({
    required FaktoAppState super.notifier,
    required super.child,
    super.key,
  });

  static FaktoAppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<FaktoAppScope>();
    assert(scope != null, 'FaktoAppScope must wrap the application.');
    return scope!.notifier!;
  }
}
