import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/myoo/src/actions/client_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/widgets/loading_widget.dart';
import 'package:redux/redux.dart';

/// 'Lobby' Page while initiating [AppState]
class InitializationPage extends StatelessWidget {
  const InitializationPage({Key? key}) : super(key: key);

  void onLoaded(Store<AppState> store, BuildContext context) {
    final route = store.state.currentClient == null ? '/login' : '/home';
    Future.delayed(const Duration(seconds: 2))
      .then((value) => Navigator.of(context).pushNamed(route));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreBuilder<AppState>(
        onInitialBuild: (store) => store.dispatch(LoadStoredClientsAction()),
        builder: (context, store) {
          if (store.state.isLoading == false) {
            onLoaded(store, context);
          }
          return const LoadingWidget();
        }
      )
    );
  }
}
