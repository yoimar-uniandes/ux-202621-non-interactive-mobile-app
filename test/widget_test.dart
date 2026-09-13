import 'package:fakto_mobile/app/fakto_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the mobile foundation', (tester) async {
    await tester.pumpWidget(const FaktoApp());
    expect(find.text('Hola, Claudia'), findsOneWidget);
  });
}
