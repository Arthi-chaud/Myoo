import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/myoo/src/actions/client_actions.dart';
import 'package:myoo/myoo/src/actions/navigation_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/views/login_dialog.dart';


/// Dialog to manage (delete, connect, add new one) connected server(s)
class ServerManagementDialog extends StatelessWidget {
  const ServerManagementDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {
        if (store.state.currentClient == null) {
          return Container();
        }
        KyooClient currentClient = store.state.currentClient!;
        List<KyooClient> otherClients = List.from(store.state.clients!)..remove(currentClient);
        var screenSize = MediaQuery.of(context).size;
        return AlertDialog(
          backgroundColor: getColorScheme(context).background,
          scrollable: true,
          title: const Text('Manage servers'),
          actions: [
            TextButton(
              onPressed: () => showLoginDialog(context),
              child: Text(
                "Add new server",
                style: TextStyle(color: getColorScheme(context).onBackground),
              ),
            )
          ],
          content: SizedBox(
            width: screenSize.width * 0.7,
            height: screenSize.height * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClientTile(
                  serverURL: currentClient.serverURL,
                  onDelete: () {
                    if (otherClients.isEmpty) {
                      store.dispatch(NavigatorPopAction());
                      showLoginDialog(context, disposable: false, transparentBarrier: false);
                    } else {
                      store.dispatch(UseClientAction(otherClients.first));
                    }
                    store.dispatch(DeleteClientAction(currentClient));
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
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
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
