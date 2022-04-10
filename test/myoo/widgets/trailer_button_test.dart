import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoo/myoo/src/widgets/trailer_button.dart';

Future<void> buildTrailerButton(WidgetTester tester) async {
  await tester.pumpWidget(
    const Directionality(
      textDirection: TextDirection.ltr,
      child: Material(
        child: TrailerButton('https://google.com')
      ),
    )
  );
}

void main() {
  group('TrailerButton', () {
    testWidgets('Has a label & an icon', (WidgetTester tester) async {
      await buildTrailerButton(tester);

      final iconFinder = find.byIcon(Icons.local_movies);
      final labelFinder = find.text('Trailer');

      expect(iconFinder, findsOneWidget);
      expect(labelFinder, findsOneWidget);
    });
    testWidgets('Open brower on tap', (WidgetTester tester) async {
      await buildTrailerButton(tester);

      await tester.tap(find.byType(InkWell));
      await tester.pump(const Duration(seconds: 2));
print(tester.layers.last.toStringDeep());
    });
  });
}
