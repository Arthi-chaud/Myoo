import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/myoo/src/actions/client_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/widgets/loading_widget.dart';

/// 'Lobby' Page while initiating [AppState]
class InitializationPage extends StatefulWidget {
  const InitializationPage({Key? key}) : super(key: key);

  @override
  State<InitializationPage> createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {
  /// If a currentClient is set, it is connected
  /// Otherwise, a login is required
  void onLoaded(AppState store, BuildContext context) {
    final route = store.currentClient == null ? '/login' : '/list';
    Future.delayed(const Duration(seconds: 2))
      .then((value) {
        Navigator.of(context).popAndPushNamed(route);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        onInit: (store) => store.dispatch(LoadStoredClientsAction()),
        ignoreChange: (store) => store.isLoading == false,
        builder: (context, store) {
          if (store.isLoading == false) {
            onLoaded(store, context);
          }
          return const LoadingWidget();
        }
      )
    );
  }
}
