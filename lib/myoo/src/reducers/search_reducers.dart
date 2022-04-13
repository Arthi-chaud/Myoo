import 'package:myoo/myoo/myoo_api.dart';
import 'package:myoo/myoo/src/actions/search_actions.dart';
import 'package:myoo/myoo/src/models/search_result.dart';
import 'package:redux/redux.dart';

final searchReducers = combineReducers<SearchResult?>([
  TypedReducer<SearchResult?, ClearSearch>((_, __) => null),
  TypedReducer<SearchResult?, SearchedItems>(_searchedItems),
]);

SearchResult _searchedItems(SearchResult? old, action) {
  return (action as ContainerAction<SearchResult>).content;
}
