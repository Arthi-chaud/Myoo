import 'package:myoo/myoo/myoo_api.dart';
import 'package:myoo/myoo/src/models/search_result.dart';

/// Action to search items
/// [query] is the query [String] from thr user
class SearchItems extends ContainerAction<String> {
  SearchItems(String query) : super(content: query);
}

/// Action when items where searched
class SearchedItems extends ContainerAction<SearchResult> {
  SearchedItems(SearchResult result) : super(content: result);
}

/// Action to clear search result
class ClearSearch extends Action {}
