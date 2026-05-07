import 'package:flutter_test/flutter_test.dart';
import 'package:ballade_art/main.dart';

void main() {
  testWidgets('App starts', (WidgetTester tester) async {
    await tester.pumpWidget(const BalladeArtApp());
    await tester.pump(); // first frame
    expect(find.byType(BalladeArtApp), findsOneWidget);
  });
}