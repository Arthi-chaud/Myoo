import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/myoo/myoo_api.dart';
import 'package:redux/redux.dart';
import '../../../mock.dart';
import '../../../store.dart';

void main() async {
  final fileContent = await File('test/kyoo_api/assets/season.json').readAsString();
  final showJSON = jsonDecode(fileContent);
  final mockClient =  mockKyooAPI({'/api/seasons/bla': fileContent, '/api/show/bla/staff': '{"items": []}'});
  final KyooClient client1 = KyooClient(
    serverURL: 'toto',
    client: mockClient
  );

  Store<AppState> store = await createTestStore();
  store.dispatch(NewClientConnectedAction(client1));
  group('Season Reducers', () {
    test('Load Season', () async {
      store.dispatch(LoadSeasonAction('bla'));
      expect(store.state.isLoading, true);
      await Future.delayed(const Duration(seconds: 1));
      expect(store.state.currentSeason!.name, showJSON['title']);
      expect(store.state.isLoading, false);
    });

    test('Unset Season', () {
      store.dispatch(UnloadSeasonAction());
      expect(store.state.currentSeason, null);
    });
  });
}
