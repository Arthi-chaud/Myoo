import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoo/kyoo_api/src/models/external_id.dart';
import 'package:myoo/kyoo_api/src/models/metadata_provider.dart';
import 'package:myoo/myoo/src/widgets/info_button.dart';

Future<void> buildInfoButton(WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: Material(
          child: InfoButton(
            externalIDs: [
              ExternalID(provider: MetadataProvider(id: 1, slug: '', name: 'TheTVDB', logo: ''), externalURL: ''),
              ExternalID(provider: MetadataProvider(id: 1, slug: '', name: 'TheMovieDB', logo: ''), externalURL: '')
            ]
          )
        ),
      ),
    )
  );
}

void main() {
  group('InfoButton', () {
    testWidgets('Has a label & an icon', (WidgetTester tester) async {
      await buildInfoButton(tester);

      final iconFinder = find.byIcon(Icons.info);
      final labelFinder = find.text('Info');

      expect(iconFinder, findsOneWidget);
      expect(labelFinder, findsOneWidget);
    });
    testWidgets('Display list of providers', (WidgetTester tester) async {
      await buildInfoButton(tester);

      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();
      expect(find.text('TheTVDB'), findsOneWidget);
      expect(find.text('TheMovieDB'), findsOneWidget);
    });
  });
}
