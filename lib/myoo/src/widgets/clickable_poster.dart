import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/src/models/resource_preview.dart';
import 'package:myoo/myoo/src/actions/collection_actions.dart';
import 'package:myoo/myoo/src/actions/movie_actions.dart';
import 'package:myoo/myoo/src/actions/tv_series_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:redux/redux.dart';

/// Widget to display a [Movie]/[TVSeries]/[Collection] poster in a list
/// It is not used for an item's detail pages
/// On tap, change the [AppState] and navigate to detail page
class ClickablePoster extends StatelessWidget{
  /// [ResourcePreview] of which the poster is displayed
  final ResourcePreview resource;

  /// Default constructor
  const ClickablePoster({Key? key, required this.resource}) : super(key: key);

  static const double posterHeight = 150;
  static const double posterWidth = posterHeight * 2 /3;
  static const double posterRatio = 1 / 2;
  static const double textSize = 14;

  Widget emptyPoster(BuildContext context) => SizedBox(
    height: posterHeight,
    width: posterWidth,
    child: Container(
      color: getColorScheme(context).surface,
    ),
  );

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
      child: Column(
        children: [
          resource.poster != null ?
            CachedNetworkImage(
              imageUrl: resource.poster!,
              height: posterHeight,
              width: posterWidth,
              fit: BoxFit.cover,
              placeholder: (_, __) => emptyPoster(context),
              errorWidget: (_, __, ___) => emptyPoster(context)
            )
          : emptyPoster(context),
          SizedBox(
            width: posterWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                resource.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: textSize,
                  color: getColorScheme(context).onPrimary
                ),
              ),
            ),
          ),
          Text(
            resource.maxDate == null || resource.maxDate?.year == resource.minDate?.year
              ? resource.minDate?.year.toString() ?? ''
              : "${resource.minDate!.year.toString()} - ${resource.maxDate!.year.toString()}",
            style: TextStyle(
              fontSize: textSize * 0.8,
              overflow: TextOverflow.ellipsis,
              color: getColorScheme(context).onPrimary,
              fontWeight: FontWeight.w200
            ),
          ),
        ]
      )
    );
  }
}
