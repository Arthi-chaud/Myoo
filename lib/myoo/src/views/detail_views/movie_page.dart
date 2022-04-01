import 'package:flutter/material.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/myoo/src/actions/movie_actions.dart';
import 'package:myoo/myoo/src/actions/navigation_actions.dart';
import 'package:myoo/myoo/src/actions/video_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/widgets/detail_page/staff_list.dart';
import 'package:myoo/myoo/src/widgets/detail_page/expandable_overview.dart';
import 'package:myoo/myoo/src/widgets/detail_page/header.dart';
import 'package:myoo/myoo/src/widgets/detail_page/scaffold.dart';
import 'package:myoo/myoo/src/widgets/detail_page/show_info.dart';
import 'package:myoo/myoo/src/widgets/download_button.dart';
import 'package:myoo/myoo/src/widgets/trailer_button.dart';

/// View to display cuurentMovie of [AppState]
class MoviePage extends StatelessWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    DetailPageScaffold(
      isLoading: (store) => store.state.currentMovie == null,
      onDispose: (store) => store.dispatch(UnloadMovieAction()),
      builder: (context, store) {
        Movie movie = store.state.currentMovie!;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DetailPageHeader(
              thumbnailURL: movie.thumbnail,
              posterURL: movie.poster,
              sideWidget: ShowInfo(
                title: movie.name,
                genres: movie.genres,
                releaseDate: movie.releaseDate,
                studio: movie.studio
              )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                      flex: 4,
                      child: ElevatedButton.icon(
                          icon: const Icon(Icons.play_arrow),
                          onPressed: () {
                            store.dispatch(SetCurrentVideo(movie));
                            store.dispatch(NavigatorPushAction('/play'));
                          },
                          label: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                            child: Text("Play")
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: getColorScheme(context).secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                            )
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (movie.trailer != null)
                            TrailerButton(movie.trailer!),
                            DownloadButton(
                              store.state.currentClient!.getDownloadLink(movie.slug)
                            ),
                          ],
                        )
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: ExpandableOverview(movie.overview, maxLines: 5),
                  ),
                ],
              )
            ),
            ExpandableStaffList(movie.staff),
          ],
        );
      }
    );
}
