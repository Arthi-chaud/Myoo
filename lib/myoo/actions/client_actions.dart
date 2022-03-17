
import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/myoo/actions/action_model.dart';

/// Action when retrieving [KyooClient]s from storage ([SharedPreferences])
class LoadStoredClientsAction extends Action {}

/// Action when [KyooClient]s are successfully (ie at least one) pulled from local storage
class LoadedStoredClientsAction extends ContainerAction<List<KyooClient>>{
  LoadedStoredClientsAction(List<KyooClient> list): super(content: list);
}

/// Action when [KyooClient]s pulled from local storage failed (ie no [KyooClient] pulled)
class NoLoadedStoredClientsAction extends Action{}

/// Action when a new [KyooClient] is connected, sets as currentClient in [AppState]
class NewClientConnectedAction extends ContainerAction<KyooClient>{
  NewClientConnectedAction(KyooClient newClient): super(content: newClient);
}

/// Action when a [KyooClient] is disconnected (by user, or when a JWT rots)
class DisconnectClientAction extends ContainerAction<KyooClient>{
  DisconnectClientAction(KyooClient toRemove): super(content: toRemove);
}
