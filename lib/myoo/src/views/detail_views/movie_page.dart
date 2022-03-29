import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/widgets/detail_page/expandable_overview.dart';
import 'package:myoo/myoo/src/widgets/detail_page/header.dart';
import 'package:myoo/myoo/src/widgets/detail_page/icon_button.dart';
import 'package:myoo/myoo/src/widgets/detail_page/scaffold.dart';
import 'package:myoo/myoo/src/widgets/detail_page/show_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

void download(a, b, c) => print(c);

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
                              onTap: () async {
                                Directory directory = await getApplicationDocumentsDirectory();
                                String ext = await store.state.currentClient!.getFileExtension(movie.slug);
                                FlutterDownloader.registerCallback(download);
                                FlutterDownloader.enqueue(
                                  url: store.state.currentClient!.getDownloadLink(movie.slug),
                                  savedDir: directory.path,
                                  fileName: "${movie.slug}.$ext",
                                  saveInPublicStorage: true
                                );
                              }, ///TODO Manage downloads
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
                    child: ExpandableOverview(movie.overview, maxLines: 5),
                  )
                ]
              )
            )
          ],
        );
      }
    );
}
