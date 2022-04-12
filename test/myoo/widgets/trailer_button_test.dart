import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoo/myoo/src/widgets/trailer_button.dart';

import '../../widget_builder.dart';

Future<void> buildTrailerButton(WidgetTester tester) async {
  await tester.pumpWidget(
    await build(
      const TrailerButton('https://google.com')
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
  });
}
