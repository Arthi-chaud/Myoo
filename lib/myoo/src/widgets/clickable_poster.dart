import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/src/models/resource_preview.dart';
import 'package:myoo/myoo/src/actions/collection_actions.dart';
import 'package:myoo/myoo/src/actions/movie_actions.dart';
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
            store.dispatch(LoadCollectionAction(resource.slug));
            Navigator.of(context).pushNamed('/collection');
            break;
          case ResourcePreviewType.movie:
            store.dispatch(LoadMovieAction(resource.slug));
            Navigator.of(context).pushNamed('/movie');
            break;
          case ResourcePreviewType.series:
            store.dispatch(LoadTVSeriesAction(resource.slug));
            Navigator.of(context).pushNamed('/series');
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
