import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/widgets/detail_page/header.dart';
import 'package:myoo/myoo/src/widgets/detail_page/scaffold.dart';
import 'package:myoo/myoo/src/widgets/detail_page/show_info.dart';

/// View to display cuurentMovie of [AppState]
class TVSeriesPage extends StatelessWidget {
  const TVSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailPageScaffold(
      isLoading: (store) => store.state.currentTVSeries == null,
      builder: (context, store) {
        TVSeries tvSeries = store.state.currentTVSeries!;
        int initialSeasonIndex = 0;
        if (tvSeries.seasons.first.name.toLowerCase().contains("specials") || // If specials
          tvSeries.seasons.first.name.toLowerCase().endsWith(" 0")) { // if season 0
          initialSeasonIndex = 1;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailPageHeader(
              thumbnailURL: tvSeries.thumbnail,
              posterURL: tvSeries.poster,
              sideWidget: ShowInfo(
                title: tvSeries.name,
                genres: tvSeries.genres,
                releaseDate: tvSeries.releaseDate,
                endDate: tvSeries.endDate,
                studio: tvSeries.studio
              )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: ExpandableText(
                      tvSeries.overview,
                      expandText: 'Show more',
                      maxLines: 5,
                      linkColor: getColorScheme(context).onBackground,
                      linkStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (tvSeries.seasons.length == 1)
                  Text(tvSeries.seasons.first.name),
                ],
              ),
            ),
            if (tvSeries.seasons.length > 1)
            DefaultTabController(
              length: tvSeries.seasons.length,
              initialIndex: initialSeasonIndex,
              child: TabBar(
                isScrollable: true,
                indicatorColor: getColorScheme(context).secondary,
                tabs: tvSeries.seasons.map(
                  (season) => Tab(text: season.name)
                ).toList()
              ),
            )
          ],
        );
      }
    );
  }
}
