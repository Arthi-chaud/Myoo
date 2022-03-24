import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/src/models/collection.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/widgets/detail_page/scaffold.dart';
import 'package:myoo/myoo/src/widgets/clickable_poster.dart';
import 'package:myoo/myoo/src/widgets/poster.dart';
import 'package:myoo/myoo/src/widgets/thumbnail.dart';

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
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 150),
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Thumbnail(thumbnailURL: collection.thumbnail),
                    Positioned(
                      bottom: -150,
                      child: Poster(
                        posterURL: collection.poster,
                        title: collection.name,
                        titleSize: 18,
                        height: 220,
                      )
                    ),
                  ],
                )
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
