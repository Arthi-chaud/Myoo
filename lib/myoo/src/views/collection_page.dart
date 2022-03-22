import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/src/models/collection.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/widgets/detail_page/scaffold.dart';

/// View to display currentCollection of [AppState]
class CollectionPage extends StatelessWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailPageScaffold(
      child: StoreBuilder<AppState>(
        builder: (context, store) {
          Collection collection = store.state.currentCollection!;
          return Center(child: Text(collection.name));
        }
      )
    );
  }
}
