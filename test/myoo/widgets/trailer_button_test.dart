import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoo/myoo/src/widgets/trailer_button.dart';

void main() {
  group('TrailerButton', () {
    testWidgets('TrailerButton has a label & an icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Material(
            child: TrailerButton('https://google.com')
          ),
        )
      );

      final iconFinder = find.byIcon(Icons.local_movies);
      final labelFinder = find.text('Trailer');

      expect(iconFinder, findsOneWidget);
      expect(labelFinder, findsOneWidget);
    });
  });
}
