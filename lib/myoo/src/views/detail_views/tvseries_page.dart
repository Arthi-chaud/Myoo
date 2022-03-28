import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/myoo/src/actions/season_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/widgets/detail_page/header.dart';
import 'package:myoo/myoo/src/widgets/detail_page/scaffold.dart';
import 'package:myoo/myoo/src/widgets/detail_page/show_info.dart';

/// View to display cuurentMovie of [AppState]
class TVSeriesPage extends StatelessWidget {
  const TVSeriesPage({Key? key}) : super(key: key);
  /// In the [TVSeries], retrives the index of the first 'real' season
  /// I.E. exculding specials and Season 0
  int getFirstSeasonIndex(TVSeries tvSeries) {
    List<Season> realSeasons = tvSeries.seasons.where((season) => season.index >= 1).toList();
    if (realSeasons.isEmpty) {
      return 0;
    }
    return tvSeries.seasons.indexOf(realSeasons.first);
  }

  @override
  Widget build(BuildContext context) {
    return DetailPageScaffold(
      isLoading: (store) => store.state.currentTVSeries == null,
      builder: (context, store) {
        TVSeries tvSeries = store.state.currentTVSeries!;
        Season? season = store.state.currentSeason;
        int initialSeasonIndex = getFirstSeasonIndex(tvSeries);
        if (season == null) {
          store.dispatch(LoadSeasonAction(tvSeries.seasons[initialSeasonIndex].slug));
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
                onTap: (tabIndex) {
                  store.dispatch(LoadSeasonAction(tvSeries.seasons[tabIndex].slug));
                },
                tabs: tvSeries.seasons.map(
                  (season) => Tab(text: season.name)
                ).toList()
              ),
            ),
            for (Episode episode in season?.episodes ?? [])
            Text(episode.name)
          ],
        );
      }
    );
  }
}
