import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/src/models/resource_preview.dart';
import 'package:myoo/myoo/src/actions/collection_actions.dart';
import 'package:myoo/myoo/src/actions/movie_actions.dart';
import 'package:myoo/myoo/src/actions/navigation_actions.dart';
import 'package:myoo/myoo/src/actions/tv_series_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/widgets/poster.dart';
import 'package:redux/redux.dart';

/// Widget to display a [Movie]/[TVSeries]/[Collection] poster in a list
/// It is not used for an item's detail pages
/// On tap, change the [AppState] and navigate to detail page
class ClickablePoster extends StatelessWidget{
  /// [ResourcePreview] of which the poster is displayed
  final ResourcePreview resource;

  /// Default constructor
  const ClickablePoster({Key? key, required this.resource}) : super(key: key);


  static const double posterRatio = 0.48;

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    return InkWell(
      onTap: (() {
        switch (resource.type) {
          case ResourcePreviewType.collection:
            store.dispatch(UnloadCollectionAction());
            store.dispatch(LoadCollectionAction(resource.slug));
            store.dispatch(NavigatorPushAction('/collection'));
            break;
          case ResourcePreviewType.movie:
            store.dispatch(UnloadMovieAction());
            store.dispatch(LoadMovieAction(resource.slug));
            store.dispatch(NavigatorPushAction('/movie'));
            break;
          case ResourcePreviewType.series:
            store.dispatch(UnloadTVSeriesAction());
            store.dispatch(LoadTVSeriesAction(resource.slug));
            store.dispatch(NavigatorPushAction('/series'));
            break;
          default:
        }
      }),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Poster(
          posterURL: resource.poster,
          title: resource.name,
          subtitle: resource.maxDate == null || resource.maxDate?.year == resource.minDate?.year
            ? resource.minDate?.year.toString() ?? ''
            : "${resource.minDate!.year.toString()} - ${resource.maxDate!.year.toString()}"
        )
      )
    );
  }
}
