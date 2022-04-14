import 'package:flutter_test/flutter_test.dart';
import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/myoo/myoo_api.dart';
import 'package:redux/redux.dart';
import '../../mock.dart';
import '../../store.dart';

void main() async {
  final mockClient = mockKyooAPI({'/api/items': '{"items": []}'});
  final KyooClient client1 = KyooClient(serverURL: 'toto', client: mockClient);
  final KyooClient client2 = KyooClient(serverURL: 'tata', client: mockClient);

  Store<AppState> store = await createTestStore();
  group('Client Reducers', () {
    testWidgets('Add New Client', (WidgetTester tester) async {
      store.dispatch(NewClientConnectedAction(client1));
      expect(store.state.clients!.length, 1);
      expect(store.state.clients!.first.serverURL, client1.serverURL);
      expect(store.state.currentClient!.serverURL, client1.serverURL);
    });

    testWidgets('Add Another Client', (WidgetTester tester) async {
      store.dispatch(NewClientConnectedAction(client2));
      expect(store.state.clients!.length, 2);
      expect(store.state.clients!.last.serverURL, client2.serverURL);
      expect(store.state.currentClient!.serverURL, client2.serverURL);
    });

    testWidgets('Connect Client', (WidgetTester tester) async {
      store.dispatch(UseClientAction(client1));
      expect(store.state.currentClient!.serverURL, client1.serverURL);
    });

    testWidgets('Remove Client', (WidgetTester tester) async {
      store.dispatch(UseClientAction(client2));
      expect(store.state.currentClient!.serverURL, client2.serverURL);
      store.dispatch(DeleteClientAction(client1));
      expect(store.state.clients!.length, 1);
      expect(store.state.clients!.first.serverURL, client2.serverURL);
      expect(store.state.currentClient!.serverURL, client2.serverURL);
    });
  });
}
