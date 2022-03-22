import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/src/models/collection.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/widgets/detail_page/scaffold.dart';
import 'package:myoo/myoo/src/widgets/clickable_poster.dart';

/// View to display currentCollection of [AppState]
class CollectionPage extends StatelessWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailPageScaffold(
      child: StoreBuilder<AppState>(
        builder: (context, store) {
          Collection collection = store.state.currentCollection!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: ClickablePoster.posterRatio
            ),
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            itemCount: collection.content.length,
            itemBuilder: (BuildContext context, int index) =>
              ClickablePoster(resource: collection.content[index]),
          );
        }
      )
    );
  }
}
