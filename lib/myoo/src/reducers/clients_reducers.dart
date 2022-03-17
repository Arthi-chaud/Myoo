import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/myoo/src/actions/action.dart';
import 'package:myoo/myoo/src/actions/client_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:redux/redux.dart';

/// List of reducers related to [KyooClient]s from [AppState]
final clientsReducers = combineReducers<List<KyooClient>?>([
  TypedReducer<List<KyooClient>?, LoadedStoredClientsAction>(_setClients),
  TypedReducer<List<KyooClient>?, NewClientConnectedAction>(_addClient),
  TypedReducer<List<KyooClient>?, DisconnectClientAction>(_removeClient),
]);

/// List of reducers related to [AppState]'s current [KyooClient]
final currentClientReducers = combineReducers<KyooClient?>([
  TypedReducer<KyooClient?, LoadedStoredClientsAction>(_setCurrentClient),
  TypedReducer<KyooClient?, NewClientConnectedAction>(_setCurrentClient),
  TypedReducer<KyooClient?, UseClientAction>(_setCurrentClient),
  TypedReducer<KyooClient?, DisconnectClientAction>(_unsetCurrentClient),
]);

KyooClient? _setCurrentClient(KyooClient? oldClient, action) {
  if (action is ContainerAction<KyooClient>) {
    return action.content;
  } else {
    return (action as ContainerAction<List<KyooClient>>).content.first;
  }
}

KyooClient? _unsetCurrentClient(KyooClient? _, __) => null;

List<KyooClient> _addClient(List<KyooClient>? oldClients, action) {
  List newClients = List.from(oldClients!);
  newClients.add((action as ContainerAction<KyooClient>).content);
  return List.from(newClients);
}

List<KyooClient>? _removeClient(List<KyooClient>? oldClients, action) {
  List newClients = List.from(oldClients!);
  newClients.remove((action as ContainerAction<KyooClient>).content);
  return List.from(newClients);
}

List<KyooClient>? _setClients(_, action) => (action as ContainerAction<List<KyooClient>>).content;
