import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/widgets/detail_page/scaffold.dart';

/// View to display cuurentMovie of [AppState]
class MoviePage extends StatelessWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailPageScaffold(
      child: StoreConnector<AppState, Movie>(
        converter: (store) => store.state.currentMovie!,
        builder: (context, movie) {
          return Center(child: Text("Movie: ${movie.name}"));
        }
      )
    );
  }
}
