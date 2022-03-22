import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:myoo/kyoo_api/src/models/resource_preview.dart';
import 'package:myoo/myoo/src/actions/client_actions.dart';
import 'package:myoo/myoo/src/actions/library_actions.dart';
import 'package:myoo/myoo/src/actions/loading_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/models/library_content.dart';
import 'package:myoo/myoo/src/widgets/loading_widget.dart';
import 'package:myoo/myoo/src/widgets/poster_tile.dart';

/// Page to list all libraries and their content from a server
class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StoreBuilder<AppState>(
          onInit: (store) {
            store.dispatch(SetCurrentLibraryAction(const LibraryContent(fullyLoaded: false, content: [])));
            store.dispatch(LoadAction());
            store.dispatch(LoadLibraries(store.state.currentClient!));
            store.dispatch(LoadContentFromLibrary(store.state.currentLibrary));
          },
          builder: (context, store) {
            if (store.state.isLoading && store.state.currentLibrary == null) {
              return const LoadingWidget();
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 2,
              ),
              itemCount: store.state.currentLibrary!.content.length,
              itemBuilder: (context, index) {
                ResourcePreview preview = store.state.currentLibrary!.content[index];
                return LazyLoadingList(
                  loadMore: () => store.dispatch(LoadContentFromLibrary(store.state.currentLibrary)),
                  child: PosterTile(
                    imageURL: preview.poster,
                    title: preview.name,
                  ),
                  index: index,
                  hasMore: store.state.currentLibrary!.fullyLoaded == false
                );
              }
            );
          }
        )
      )
    );
}
