import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/kyoo_api/src/models/library.dart';
import 'package:myoo/myoo/src/actions/action.dart';
import 'package:myoo/myoo/src/actions/client_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:redux/redux.dart';

/// List of reducers related to [KyooClient]s from [AppState]
final clientsReducers = combineReducers<List<KyooClient>?>([
  TypedReducer<List<KyooClient>?, LoadedStoredClientsAction>(_setClients),
  TypedReducer<List<KyooClient>?, NewClientConnectedAction>(_addClient),
  TypedReducer<List<KyooClient>?, DeleteClientAction>(_removeClient),
]);

/// List of reducers related to [AppState]'s current [KyooClient]
final currentClientReducers = combineReducers<KyooClient?>([
  TypedReducer<KyooClient?, LoadedStoredClientsAction>(_setCurrentClient),
  TypedReducer<KyooClient?, NewClientConnectedAction>(_setCurrentClient),
  TypedReducer<KyooClient?, UseClientAction>(_setCurrentClient),
  TypedReducer<KyooClient?, DeleteClientAction>(_unsetCurrentClient),
  TypedReducer<KyooClient?, LoadedLibraries>(_setLibraries),
]);

/// Sets [AppState]'s current [KyooClient]
KyooClient? _setCurrentClient(KyooClient? oldClient, action) {
  if (action is ContainerAction<KyooClient>) {
    return action.content;
  } else {
    return (action as ContainerAction<List<KyooClient>>).content.first;
  }
}

/// Unsets [AppState]'s current [KyooClient]  (set to null) if the action content is the current client
KyooClient? _unsetCurrentClient(KyooClient? old, action) {
  if (old! == (action as ContainerAction<KyooClient>).content) {
    return null;
  } else {
    return old;
  }
}

/// Adds new [KyooClient] to [AppState]'s [KyooClient]s
List<KyooClient> _addClient(List<KyooClient>? oldClients, action) =>
  List.from(oldClients ?? [])
    ..add((action as ContainerAction<KyooClient>).content);

/// Removes new [KyooClient] to [AppState]'s [KyooClient]s
List<KyooClient>? _removeClient(List<KyooClient>? oldClients, action) =>
  List.from(oldClients!)
    ..remove((action as ContainerAction<KyooClient>).content);

/// Resets [AppState]'s [KyooClient]s
List<KyooClient>? _setClients(_, action) =>
    (action as ContainerAction<List<KyooClient>>).content;

KyooClient? _setLibraries(KyooClient? old, ContainerAction<List<Library>> action) {
  return KyooClient(
    serverURL: old!.serverURL,
    jwt: old.jwt,
    serverLibraries: action.content,
    client: old.client
  );
}
