import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/myoo/src/actions/client_actions.dart';
import 'package:myoo/myoo/src/actions/library_actions.dart';
import 'package:myoo/myoo/src/actions/navigation_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';


/// Dialog to manage (delete, connect, add new one) connected server(s)
class ServerManagementDialog extends StatelessWidget {
  const ServerManagementDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {
        KyooClient currentClient = store.state.currentClient!;
        List<KyooClient> otherClients = List.from(store.state.clients!)..remove(currentClient);
        var screenSize = MediaQuery.of(context).size;
        return AlertDialog(
          scrollable: true,
          title: const Text('Manage servers'),
          content: SizedBox(
            width: screenSize.width * 0.7,
            height: screenSize.height * 0.5,
            child: Column(
              children: [
                ClientTile(
                  serverURL: currentClient.serverURL,
                  onDelete: () {
                    if (otherClients.isEmpty) {
                      store.dispatch(NavigatorPopAction());
                      store.dispatch(NavigatorPopAndPushAction('/login'));
                      store.dispatch(DeleteClientAction(currentClient));
                    } else {
                      store.dispatch(UseClientAction(otherClients.first));
                    }
                  },
                ),
                for (KyooClient client in otherClients)
                ClientTile(
                  serverURL: client.serverURL,
                  onDelete: () => store.dispatch(DeleteClientAction(client)),
                  onConnect: () => store.dispatch(UseClientAction(client)),
                )
              ]
            ),
          ),
        );
      },
    );
  }
}

class ClientTile extends StatelessWidget {
  final String serverURL;
  final VoidCallback? onDelete;
  final VoidCallback? onConnect;
  const ClientTile({Key? key, required this.serverURL, this.onDelete, this.onConnect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: Text(
            serverURL,
          ),
        ),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onDelete,
              ),
              if (onConnect != null)
              IconButton(
                icon: const Icon(Icons.electrical_services),
                onPressed: onConnect,
              ),
            ],
          )
        ),
      ],
    );
  }
}
