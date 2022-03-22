import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:myoo/kyoo_api/src/models/resource_preview.dart';
import 'package:myoo/myoo/src/actions/client_actions.dart';
import 'package:myoo/myoo/src/actions/collection_actions.dart';
import 'package:myoo/myoo/src/actions/library_actions.dart';
import 'package:myoo/myoo/src/actions/loading_actions.dart';
import 'package:myoo/myoo/src/actions/movie_actions.dart';
import 'package:myoo/myoo/src/actions/tv_series_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/models/library_content.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/widgets/poster_tile.dart';

/// Page to list all libraries and their content from a server
class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    StoreBuilder<AppState>(
      onInit: (store) {
        store.dispatch(LoadAction());
        store.dispatch(ResetCurrentLibraryAction());
        store.dispatch(LoadLibraries(store.state.currentClient!));
        store.dispatch(LoadContentFromLibrary(store.state.currentLibrary));
      },
      builder: (context, store) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: getColorScheme(context).background,
            elevation: 30,
            title: Text(
              Uri.parse(store.state.currentClient!.serverURL).toString(),
              style: TextStyle(fontSize: 15, color: getColorScheme(context).onBackground)
            ),
            actions: [
              DropdownButton<String?>(
                value: store.state.currentLibrary?.library?.name,
                items: store.state.currentClient!.serverLibraries.map(
                  (library) => DropdownMenuItem(value: library.name, child: Text(library.name))
                ).toList()..insert(0, const DropdownMenuItem(value: null, child: Text('All'))),
                underline: Container(),
                onChanged: (selectedLib) {
                  store.dispatch(ResetCurrentLibraryAction());
                  if (selectedLib != null) {
                    store.dispatch(SetCurrentLibraryAction(
                      LibraryContent(
                        library: store.state.currentClient!.serverLibraries.firstWhere(
                          (element) => element.name == selectedLib
                        )
                      ) 
                    ));
                  }
                  store.dispatch(LoadAction());
                  store.dispatch(LoadContentFromLibrary(store.state.currentLibrary));
                }
              ),
              const IconButton(onPressed: null, icon: Icon(Icons.search))
            ]
          ),
          body: GridView.builder(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1 / 2,
            ),
            itemCount: store.state.currentLibrary!.content.length,
            itemBuilder: (context, index) {
              ResourcePreview preview = store.state.currentLibrary!.content[index];
              return LazyLoadingList(
                loadMore: () => store.dispatch(LoadContentFromLibrary(store.state.currentLibrary)),
                hasMore: store.state.currentLibrary!.fullyLoaded == false,
                index: index,
                child: InkWell(
                  onTap: (() {
                    store.dispatch(LoadAction());
                    switch (preview.type) {
                      case ResourcePreviewType.collection:
                        store.dispatch(LoadCollectionAction(preview.slug));
                        Navigator.of(context).pushNamed('/collection');
                        break;
                      case ResourcePreviewType.movie:
                        store.dispatch(LoadMovieAction(preview.slug));
                        Navigator.of(context).pushNamed('/movie');
                        break;
                      case ResourcePreviewType.series:
                        store.dispatch(LoadTVSeriesAction(preview.slug));
                        Navigator.of(context).pushNamed('/series');
                        break;
                      default:
                    }
                  }),
                  child: PosterTile(
                    imageURL: preview.poster,
                    title: preview.name,
                    subtitle: preview.maxDate == null || preview.maxDate?.year == preview.minDate?.year
                      ? preview.minDate?.year.toString()
                      : "${preview.minDate!.year.toString()} - ${preview.maxDate!.year.toString()}",
                  ),
                )
              );
            }
          )
        );
      }
    );
}
