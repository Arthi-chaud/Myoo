import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/src/models/resource_preview.dart';
import 'package:myoo/kyoo_api/src/models/staff.dart';
import 'package:myoo/myoo/myoo_api.dart';
import 'package:myoo/myoo/src/actions/search_actions.dart';
import 'package:myoo/myoo/src/models/search_result.dart';
import 'package:myoo/myoo/src/widgets/search_page/item_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final String searchFieldKey = 'Search';
  final formKey = GlobalKey<FormBuilderState>();
  Timer? searchTimer;

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      scaffold: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: getColorScheme(context).background,
          leading: const GoBackButton(),
        ),
        body: StoreConnector<AppState, SearchResult?>(
          converter: (store) => store.state.searchResult,
          onInit: (store) {
            searchTimer = Timer.periodic(const Duration(seconds: 3), (_) {
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
            searchTimer?.cancel();
            store.dispatch(ClearSearch());
          },
          builder: (context, searchResult) {
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
                    ///TODO EPISODES
                    if (searchResult.staff.isNotEmpty)
                    ///TODO Make it clickable
                    SearchItemList<StaffMember>(
                      label: "Staff",
                      items: searchResult.staff,
                      itemBuilder: (staffMember) => Poster(
                        posterURL: staffMember.poster,
                        title: staffMember.name,
                      ),
                    )
                  ]
                ],
              )
            );
          },
        )
      )
    );
  }
}
