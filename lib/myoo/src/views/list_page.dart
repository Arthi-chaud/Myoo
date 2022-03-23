
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:myoo/kyoo_api/src/models/resource_preview.dart';
import 'package:myoo/myoo/src/actions/client_actions.dart';
import 'package:myoo/myoo/src/actions/library_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/models/library_content.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/widgets/clickable_poster.dart';

/// Page to list all libraries and their content from a server
class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    StoreBuilder<AppState>(
      onInit: (store) {
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
              childAspectRatio: ClickablePoster.posterRatio,
            ),
            itemCount: store.state.currentLibrary!.content.length,
            itemBuilder: (context, index) {
              ResourcePreview preview = store.state.currentLibrary!.content[index];
              return LazyLoadingList(
                loadMore: () => store.dispatch(LoadContentFromLibrary(store.state.currentLibrary)),
                hasMore: store.state.currentLibrary!.fullyLoaded == false,
                index: index,
                child: ClickablePoster(resource: preview),
              );
            }
          )
        );
      }
    );
}
