import 'package:flutter_test/flutter_test.dart';
import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/myoo/myoo_api.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/store.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../store.dart';
import '../widgets/back_button_test.dart';

void main() async {

  Store<AppState> store = await createTestStore();
  group('Client Reducerds', () {
    testWidgets('Add New Client', (WidgetTester tester) async {
      store.dispatch(NewClientConnectedAction(KyooClient(serverURL: 'toto')));
      expect(store.state.clients!.length, 1);
      expect(store.state.clients!.first.serverURL, 'toto');
    });
    testWidgets('Connect Client', (WidgetTester tester) async {
      store.dispatch(UseClientAction(KyooClient(serverURL: 'toto')));
      expect(store.state.currentClient!.serverURL, 'toto');
    });
  });
}