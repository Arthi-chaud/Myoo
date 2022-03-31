import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:myoo/myoo/src/actions/client_actions.dart';
import 'package:myoo/myoo/src/actions/library_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/models/library_content.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/views/server_management_modal.dart';
import 'package:myoo/myoo/src/widgets/clickable_poster.dart';
import 'package:myoo/myoo/src/widgets/loading_widget.dart';
import 'package:myoo/myoo/src/widgets/safe_scaffold.dart';
import 'package:responsive_grid/responsive_grid.dart';

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
        if (store.state.currentClient == null) {
          return const Center(child: LoadingWidget());
        }
        return SafeScaffold(
          scaffold: Scaffold(
            appBar: AppBar(
              backgroundColor: getColorScheme(context).background,
              elevation: 30,
              title: Text(
                store.state.currentClient!.serverURL,
                style: TextStyle(fontSize: 15, color: getColorScheme(context).onBackground)
              ),
              actions: [
                DropdownButton<String?>(
                  dropdownColor: getColorScheme(context).background,
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
                const IconButton(onPressed: null, icon: Icon(Icons.search)),
                IconButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => const ServerManagementDialog()
                  ),
                  icon: const Icon(Icons.more_vert)
                )
              ]
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: LazyLoadScrollView(
                scrollOffset: 200,
                isLoading: store.state.isLoading || store.state.currentLibrary == null,
                onEndOfPage: () => store.dispatch(LoadContentFromLibrary(store.state.currentLibrary)),
                child: ResponsiveGridList(
                  desiredItemWidth: 100,
                  minSpacing: 8,
                  children: store.state.currentLibrary!.content.map(
                    (preview) => ClickablePoster(resource: preview),
                  ).toList()
                ),
              ),
            ),
          ),
        );
      }
    );
}
