import 'package:flutter/material.dart';
import 'package:myoo/kyoo_api/src/models/collection.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/widgets/detail_page/header.dart';
import 'package:myoo/myoo/src/widgets/detail_page/scaffold.dart';
import 'package:myoo/myoo/src/widgets/clickable_poster.dart';
import 'package:responsive_grid/responsive_grid.dart';

/// View to display currentCollection of [AppState]
class CollectionPage extends StatelessWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailPageScaffold(
      isLoading: (store) => store.state.currentCollection == null,
      builder: (context, store) {
        Collection collection = store.state.currentCollection!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailPageHeader(
              thumbnailURL: collection.thumbnail,
              posterURL: collection.poster,
              title: collection.name,
            ),
            ResponsiveGridList(
              desiredItemWidth: 100,
              minSpacing: 8,
              scroll: false,
              rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: store.state.currentCollection!.content.map(
                (preview) => ClickablePoster(resource: preview),
              ).toList()
            )
          ],
        );
      }
    );
  }
}
