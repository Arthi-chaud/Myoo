import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/widgets/detail_page/header.dart';
import 'package:myoo/myoo/src/widgets/detail_page/scaffold.dart';
import 'package:expandable_text/expandable_text.dart';

/// View to display cuurentMovie of [AppState]
class MoviePage extends StatelessWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    DetailPageScaffold(
      child: StoreConnector<AppState, Movie>(
        converter: (store) => store.state.currentMovie!,
        builder: (context, movie) =>
          Column(
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
                        fontSize: 20
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        movie.releaseDate.year.toString() + (movie.studio != null ? ", ${movie.studio}" : ""),
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
                padding: const EdgeInsets.all(20),
                child: ExpandableText(
                    movie.overview,
                    expandText: 'Show more',
                    maxLines: 5,
                    linkColor: getColorScheme(context).onBackground,
                    linkStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
              ),
            ],
          )
        ),
    );
}
