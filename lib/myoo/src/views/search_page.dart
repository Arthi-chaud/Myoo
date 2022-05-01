import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/kyoo_api/src/models/resource_preview.dart';
import 'package:myoo/kyoo_api/src/models/staff.dart';
import 'package:myoo/myoo/myoo_api.dart';
import 'package:myoo/myoo/src/actions/search_actions.dart';
import 'package:myoo/myoo/src/models/search_result.dart';
import 'package:myoo/myoo/src/widgets/episode_vertical_tile.dart';
import 'package:myoo/myoo/src/widgets/search_page/item_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final String searchFieldKey = 'Search';
  final formKey = GlobalKey<FormBuilderState>();
  /// The time that manage search callback periodically
  Timer? searchTimer;
  /// When we switch client in search tab bar, the [currentClient] from state is changed
  /// To recover initial client on dispose, we store it in a variable
  late KyooClient backupClient;

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      scaffold: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: getColorScheme(context).background,
          leading: const GoBackButton(),
        ),
        body: StoreBuilder<AppState>(
          onInit: (store) {
            backupClient = store.state.currentClient!;
            searchTimer = Timer.periodic(const Duration(seconds: 1), (_) {
              if (store.state.isLoading) {
                return;
              }
              formKey.currentState?.save();
              String? value = formKey.currentState?.value[searchFieldKey];
              if (value != null && value.isNotEmpty) {
                if (store.state.searchResult?.query != value || store.state.searchResult == null) {
                  store.dispatch(SearchItems(value));
                }
              }
            });
          },
          onDispose: (store) {
            store.dispatch(ClearSearch());
            store.dispatch(UseClientAction(backupClient));
            searchTimer?.cancel();
          },
          builder: (context, store) {
            SearchResult? searchResult = store.state.searchResult;
            return FormBuilder(
              key: formKey,
              initialValue: {
                searchFieldKey: '',
              },
              autovalidateMode: AutovalidateMode.disabled,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: FormInput(name: searchFieldKey, title: searchFieldKey),
                  ),
                  if (store.state.clients!.length > 1)
                  DefaultTabController(
                    length: store.state.clients!.length,
                    child: TabBar(
                      onTap: (index) {
                        store.dispatch(UseClientAction(store.state.clients![index]));
                        store.dispatch(ClearSearch());
                      },
                      indicatorColor: getColorScheme(context).secondary,
                      tabs: store.state.clients!.map(
                        (client) => Tab(
                          text: client.serverURL,
                        ),
                      ).toList()
                    ),
                  ),
                  if (searchResult != null)
                  ...[
                    if (searchResult.movies.isNotEmpty)
                    SearchItemList<ResourcePreview>(
                      label: "Movies",
                      items: searchResult.movies,
                      itemBuilder: (item) => ClickablePoster(
                        resource: item
                      ),
                    ),
                    if (searchResult.tvSeries.isNotEmpty)
                    SearchItemList<ResourcePreview>(
                      label: "TV Shows",
                      items: searchResult.tvSeries,
                      itemBuilder: (item) => ClickablePoster(
                        resource: item
                      ),
                    ),
                    if (searchResult.collections.isNotEmpty)
                    SearchItemList<ResourcePreview>(
                      label: "Collections",
                      items: searchResult.collections,
                      itemBuilder: (item) => ClickablePoster(
                        resource: item
                      ),
                    ),
                    if (searchResult.episodes.isNotEmpty)
                    SearchItemList<Episode>(
                      label: "Episodes",
                      items: searchResult.episodes,
                      itemBuilder: (episode) => InkWell(
                        onTap: () => store.dispatch(NavigatorPushAction('/play/${episode.slug}')),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: EpisodeVerticalTile(
                            title: episode.name,
                            overview: episode.overview ?? "",
                            thumbnailURL: episode.thumbnail,
                          ),
                        ),
                      ),
                    ),
                    if (searchResult.staff.isNotEmpty)
                    SearchItemList<StaffMember>(
                      label: "Staff",
                      items: searchResult.staff,
                      itemBuilder: (staffMember) => Poster(
                        posterURL: staffMember.poster,
                        title: staffMember.name,
                      ),
                    )
                  ].map(
                    (widget) => Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: widget,
                    )
                  )
                ],
              )
            );
          },
        )
      )
    );
  }
}
