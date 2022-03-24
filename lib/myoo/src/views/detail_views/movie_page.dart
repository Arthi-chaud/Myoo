import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/widgets/detail_page/header.dart';
import 'package:myoo/myoo/src/widgets/detail_page/scaffold.dart';
import 'package:myoo/myoo/src/widgets/poster.dart';

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
                sideWidget: Poster(posterURL: movie.poster,),
                height: 400,
              )
            ],
          )
        ),
    );
}
