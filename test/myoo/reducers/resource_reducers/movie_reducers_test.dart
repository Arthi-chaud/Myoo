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
  final fileContent = await File('test/kyoo_api/assets/collection.json').readAsString();
  final movieJSON = jsonDecode(fileContent);
  final mockClient =  mockKyooAPI({'/api/shows/bla': fileContent, '/api/show/bla/staff': '{"items": []}'});
  final KyooClient client1 = KyooClient(
    serverURL: 'toto',
    client: mockClient
  );

  Store<AppState> store = await createTestStore();
  store.dispatch(NewClientConnectedAction(client1));
  group('Movie Reducers', () {
    test('Load Movie', () async {
      store.dispatch(LoadMovieAction('bla'));
      await Future.delayed(const Duration(seconds: 1));
      expect(store.state.currentMovie!.name, movieJSON['name']);
    });
    test('Set Movie', () {
      store.dispatch(SetCurrentMovie(Movie.fromJson(movieJSON)));
      expect(store.state.currentMovie!.name, movieJSON['name']);
    });

    test('Unset Movie', () {
      store.dispatch(UnloadMovieAction());
      expect(store.state.currentMovie, null);
    });
  });
}
