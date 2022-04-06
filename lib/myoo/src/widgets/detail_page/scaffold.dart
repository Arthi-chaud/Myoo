import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/widgets/back_button.dart';
import 'package:myoo/myoo/src/widgets/loading_widget.dart';
import 'package:myoo/myoo/src/widgets/safe_scaffold.dart';
import 'package:redux/redux.dart';

/// Common Scaffold for all detail page ([MoviePage], [CollectionPage], [TVSeriesPage])
/// If Store is still loading ressource, display [LoadingWidget]
class DetailPageScaffold extends StatelessWidget {
  /// Function to determine if the page should be in a loading state, by looking at the [AppState]
  /// Usually, it check if somme current [Resource] is null
  final bool Function(Store<AppState> store) isLoading;
  /// Function to build Scaffold's child using parameters provided by [StoreBuilder]
  final Widget Function(BuildContext context, Store<AppState> store) builder;
  /// Callback on page dispose
  final void Function(Store<AppState>)? onDispose;
  const DetailPageScaffold({Key? key, required this.builder, required this.isLoading, this.onDispose}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    SafeScaffold(
      scaffold: Scaffold(
        body: DefaultTextStyle(
          style: TextStyle(fontSize: 12, color: getColorScheme(context).onBackground, height: 1.5),
          child: StoreBuilder<AppState>(
            onDispose: onDispose,
            builder: (context, store) {
              if (store.state.isLoading && isLoading(store)) {
                return const LoadingWidget();
              }
              return ListView(
                children: [
                  Stack(
                    children: [
                      builder(context, store),
                      AppBar(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        leading: const GoBackButton(),
                      ),
                    ]
                  )
                ]
              );
            }
          ),
        )
      )
    );
}
