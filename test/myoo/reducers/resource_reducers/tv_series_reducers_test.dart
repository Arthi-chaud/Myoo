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
  final fileContent = await File('test/kyoo_api/assets/tv_series.json').readAsString();
  final showJSON = jsonDecode(fileContent);
  final mockClient =  mockKyooAPI({'/api/shows/bla': fileContent, '/api/show/bla/staff': '{"items": []}'});
  final KyooClient client1 = KyooClient(
    serverURL: 'toto',
    client: mockClient
  );

  Store<AppState> store = await createTestStore();
  store.dispatch(NewClientConnectedAction(client1));
  group('TVseries Reducers', () {
    test('Load TVseries', () async {
      store.dispatch(LoadTVSeriesAction('bla'));
      expect(store.state.isLoading, true);
      await Future.delayed(const Duration(seconds: 1));
      expect(store.state.currentTVSeries!.name, showJSON['title']);
      expect(store.state.isLoading, false);
    });
    test('Set TVseries', () {
      store.dispatch(SetCurrentTVSeries(TVSeries.fromJson(showJSON)));
      expect(store.state.currentTVSeries!.name, showJSON['title']);
    });

    test('Unset TVseries', () {
      store.dispatch(UnloadTVSeriesAction());
      expect(store.state.currentTVSeries, null);
    });
  });
}
