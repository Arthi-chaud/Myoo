import 'package:flutter/material.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/widgets/detail_page/header.dart';
import 'package:myoo/myoo/src/widgets/detail_page/icon_button.dart';
import 'package:myoo/myoo/src/widgets/detail_page/scaffold.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:url_launcher/url_launcher.dart';

/// View to display cuurentMovie of [AppState]
class MoviePage extends StatelessWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    DetailPageScaffold(
      isLoading: (store) => store.state.currentMovie == null,
      builder: (context, store) {
        Movie movie = store.state.currentMovie!;
        return Column(
          children: [
            DetailPageHeader(
              thumbnailURL: movie.thumbnail,
              posterURL: movie.poster,
              sideWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                      fontSize: 19
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      movie.releaseDate != null
                      ? movie.releaseDate!.year.toString() + (movie.studio != null ? ", ${movie.studio}" : "")
                      : movie.studio ?? ""
                    )
                  ),
                  if (movie.genres.isNotEmpty) ...[
                    const Text("Genre:"),
                    ...movie.genres.take(3).map(
                      (genre) => Text("   • $genre")
                    )
                  ]
                ],
              ),
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
                          onPressed: () {}, ///TODO Open play page
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
                            DetailPageIconButton(
                              onTap: () => launch(Uri.parse(movie.trailer!).toString()),
                              icon: const Icon(Icons.local_movies),
                              label: "Trailer"
                            ),
                            DetailPageIconButton(
                              onTap: () {}, ///TODO Manage downloads
                              icon: const Icon(Icons.download),
                              label: "Download"
                            )
                          ],
                        )
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: ExpandableText(
                      movie.overview,
                      expandText: 'Show more',
                      maxLines: 5,
                      linkColor: getColorScheme(context).onBackground,
                      linkStyle: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  )
                ]
              )
            )
          ],
        );
      }
    );
}
