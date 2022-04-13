import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/myoo/myoo_api.dart';
import 'package:myoo/myoo/src/actions/search_actions.dart';
import 'package:myoo/myoo/src/models/search_result.dart';

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
                    ...[
                      const Text("Movies"),
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: searchResult.movies.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 140,
                              child: ClickablePoster(
                                resource: searchResult.movies[index],
                              ),
                            );
                          }
                        ),
                      ),
                    ]
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
