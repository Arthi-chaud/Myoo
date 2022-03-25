import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/src/models/collection.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/widgets/detail_page/header.dart';
import 'package:myoo/myoo/src/widgets/detail_page/scaffold.dart';
import 'package:myoo/myoo/src/widgets/clickable_poster.dart';

/// View to display currentCollection of [AppState]
class CollectionPage extends StatelessWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailPageScaffold(
      child: StoreConnector<AppState, Collection>(
        converter: (store) => store.state.currentCollection!,
        builder: (context, collection) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailPageHeader(
                thumbnailURL: collection.thumbnail,
                posterURL: collection.poster!,
                title: collection.name,
              ),
              GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: ClickablePoster.posterRatio
                ),
                //padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                itemCount: collection.content.length,
                itemBuilder: (BuildContext context, int index) =>
                  ClickablePoster(resource: collection.content[index]),
              ),
            ],
          );
        }
      )
    );
  }
}
