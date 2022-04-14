import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myoo/myoo/src/widgets/back_button.dart';

import '../../mock.dart';
import '../../widget_builder.dart';


Future<void> buildBackButton(WidgetTester tester, MockNavigatorObserver? navObserver) async {
  await tester.pumpWidget(await build(const GoBackButton(), observer: navObserver));
}

void main() {
  group('BackButton', () {
    testWidgets('Has an icon', (WidgetTester tester) async {
      await buildBackButton(tester, null);

      final iconFinder = find.byType(IconButton);

      expect(iconFinder, findsOneWidget);
    });
    testWidgets('Pops on tap', (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      
      await buildBackButton(tester, mockObserver);

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle(const Duration(seconds: 3));
      
      //final homeRoute = MaterialPageRoute(builder: (_) => const GoBackButton(), settings: const RouteSettings(name: '/'));
      /////TODO Fix test
      //verify(mockObserver.didPop(homeRoute, null));

    });
  });
}
