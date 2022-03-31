import 'dart:convert';

import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/myoo/src/actions/action.dart';
import 'package:myoo/myoo/src/actions/client_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef LocalStorage = SharedPreferences;

/// Returns list of middlewares related to [LocalStorage]
List<Middleware<AppState>> createLocalStorageMiddleware(SharedPreferences localStorage) => [
  TypedMiddleware<AppState, LoadStoredClientsAction>(loadStoredClientsMiddleware(localStorage)),
  TypedMiddleware<AppState, NewClientConnectedAction>(storageSetClientsMiddleWare(localStorage)),
  TypedMiddleware<AppState, DeleteClientAction>(storageRemoveClientMiddleWare(localStorage)),
  TypedMiddleware<AppState, UseClientAction>(storageReorderClients(localStorage)),
];

/// Key for [SharedPreferences] to located serialized [KyooClient]'s in [LocalStorage]
const clientsDataKey = 'clients';

/// Loads [KyooClient]s frmo Local Storage. On failure, returns [null]
List<KyooClient>? _loadRawStoredClients(SharedPreferences localStorage) =>
  localStorage
    .getStringList(clientsDataKey)
    ?.map((e) => KyooClient.fromJson(jsonDecode(e)))
    .toList();

/// Loads [KyooClient]s from Local Storage. On failure, returns [null]
void _setRawClients(SharedPreferences localStorage, List<KyooClient> clients) =>
  localStorage.setStringList(
    clientsDataKey,
    clients.map((client) => jsonEncode(client)).toList()
  );

/// Middleware to load [KyooClient]s from [LocalStorage].
Middleware<AppState> loadStoredClientsMiddleware(LocalStorage localStorage) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    List<KyooClient>? clients = _loadRawStoredClients(localStorage);
    if (clients == null || clients == []) {
      store.dispatch(NoLoadedStoredClientsAction());
    } else {
      store.dispatch(LoadedStoredClientsAction(clients));
    }
  };
}

/// Middleware to set [KyooClient]s to [LocalStorage].The action must be [ContainerAction<KyooClient>]
Middleware<AppState> storageSetClientsMiddleWare(LocalStorage localStorage) {
  return (Store<AppState> store, action, NextDispatcher next) {
    KyooClient newClient = ((action as ContainerAction<KyooClient>).content);
    List<KyooClient> toStore = List.from([...store.state.clients ?? [], newClient]);

    _setRawClients(localStorage, toStore);
    next(action);
  };
}

/// Middleware to reorder [KyooClient]s to [LocalStorage]. The action must be [ContainerAction<KyooClient>]
/// Te action's content will be put first in the list
Middleware<AppState> storageReorderClients(LocalStorage localStorage) {
  return (Store<AppState> store, action, NextDispatcher next) {
    KyooClient firstClient = ((action as ContainerAction<KyooClient>).content);
    List<KyooClient> toStore = List.from(store.state.clients ?? []);
    toStore.remove(firstClient);
    toStore.insert(0, firstClient);

    _setRawClients(localStorage, toStore);
    next(action);
  };
}

/// Middleware to remove a [KyooClient] from [LocalStorage].The action must be [ContainerAction<KyooClient>]
Middleware<AppState> storageRemoveClientMiddleWare(LocalStorage localStorage) {
  return (Store<AppState> store, action, NextDispatcher next) {
    KyooClient toRemove = ((action as ContainerAction<KyooClient>).content);
    List<KyooClient> toStore = List.from(store.state.clients!);
    toStore.remove(toRemove);
    if (toStore.isEmpty) {
      localStorage.remove(clientsDataKey);
    } else {
      _setRawClients(localStorage, toStore);
    }
    next(action);
  };
}
