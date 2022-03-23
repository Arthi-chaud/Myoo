import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/widgets/loading_widget.dart';

/// Common Scaffold for all detail page ([MoviePage], [CollectionPage], [TVSeriesPage])
/// If Store is still loading ressource, display [LoadingWidget]
class DetailPageScaffold extends StatelessWidget {
  final Widget child;
  const DetailPageScaffold({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      body: StoreConnector<AppState, bool>(
        converter: (store) => store.state.isLoading,
        builder: (context, isLoading) {
          if (isLoading) {
            return const LoadingWidget();
          }
          return ListView(
            children: [
              Stack(
                children: [
                  child,
                  AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      splashRadius: 25,
                      icon: Icon(
                        Icons.arrow_back,
                        color: getColorScheme(context).onBackground,  
                      ),
                      onPressed: () => Navigator.of(context).pop()
                    ),
                  ),
                ]
              )
            ]
          );
        }
      ),
    );
}
