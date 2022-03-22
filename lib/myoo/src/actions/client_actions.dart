import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/kyoo_api/src/models/library.dart';
import 'package:myoo/myoo/src/actions/action.dart';

/// Action when retrieving [KyooClient]s from storage ([SharedPreferences])
class LoadStoredClientsAction extends Action {}

/// Action when [KyooClient]s are successfully (ie at least one) pulled from local storage
class LoadedStoredClientsAction extends ContainerAction<List<KyooClient>> {
  LoadedStoredClientsAction(List<KyooClient> list) : super(content: list);
}

/// Action when [KyooClient]s pulled from local storage failed (ie no [KyooClient] pulled)
class NoLoadedStoredClientsAction extends Action {}

/// Action when a new [KyooClient] is connected, sets as currentClient in [AppState]
class NewClientConnectedAction extends ContainerAction<KyooClient> {
  NewClientConnectedAction(KyooClient newClient) : super(content: newClient);
}

/// Action when a [KyooClient] is selected. Client must be in [AppState]'s [KyooClient]s list
class UseClientAction extends ContainerAction<KyooClient> {
  UseClientAction(KyooClient client) : super(content: client);
}

/// Action when a [KyooClient] is disconnected (by user, or when a JWT rots)
class DisconnectClientAction extends ContainerAction<KyooClient> {
  DisconnectClientAction(KyooClient toRemove) : super(content: toRemove);
}

/// Action when to fetch [Library]es of the current server of [KyooClient]
class LoadLibraries extends ContainerAction<KyooClient> {
  LoadLibraries(KyooClient client) : super(content: client);
}

/// Action when [Library]es of the current server of [KyooClient] are fetched
class LoadedLibraries extends ContainerAction<List<Library>> {
  LoadedLibraries(List<Library> libraries) : super(content: libraries);
}
