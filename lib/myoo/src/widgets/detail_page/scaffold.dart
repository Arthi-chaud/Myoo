import 'package:decorated_icon/decorated_icon.dart';
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
    SafeArea(
      child: Scaffold(
        body: DefaultTextStyle(
          style: const TextStyle(fontSize: 12),
          child: StoreConnector<AppState, bool>(
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
                          icon: DecoratedIcon(
                            Icons.arrow_back,
                            color: getColorScheme(context).onBackground,
                            shadows: [
                              BoxShadow(
                                blurRadius: 10.0,
                                spreadRadius: 30,
                                color: getColorScheme(context).background,
                              ),
                            ],
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
        )
      )
    );
}
