import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/myoo/src/actions/client_actions.dart';
import 'package:myoo/myoo/src/actions/navigation_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/views/login_dialog.dart';
import 'package:myoo/myoo/src/widgets/loading_widget.dart';
import 'package:redux/redux.dart';

/// 'Lobby' Page while initiating [AppState]
class InitializationPage extends StatelessWidget {
  const InitializationPage({Key? key}) : super(key: key);

  void onLoaded(BuildContext context) {
    Future.delayed(const Duration(seconds: 2))
      .then((value) {
        Store<AppState> store = StoreProvider.of<AppState>(context);
        if (store.state.currentClient != null) {
          store.dispatch(NavigatorPopAndPushAction('/list'));
        } else {
          showLoginDialog(context, disposable: false);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        ignoreChange: (state) => state.isLoading == false,
        onInit: (store) => store.dispatch(LoadStoredClientsAction()),
        builder: (context, store) {
          if (store.isLoading == false) {
            onLoaded(context);
          }
          return const LoadingWidget();
        }
      )
    );
  }
}
