
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/resource_preview.dart';
import 'package:myoo/kyoo_api/src/models/staff.dart';

/// Object to store values related to the search feature
class SearchResult {
  /// List of [ResourcePreview] of [Movie]s matching the query
  final List<ResourcePreview> movies;
  /// List of [ResourcePreview] of [TVSeries] matching the query
  final List<ResourcePreview> tvSeries;
  /// List of [Episode] matching the query
  final List<Episode> episodes;
  /// List of [ResourcePreview] of [Collection]s matching the query
  final List<ResourcePreview> collections;
  /// List of [StaffMember]  matching the query
  final List<StaffMember> staff;
  /// The query string, as entered by the user
  final String? query;

  const SearchResult({
    this.movies = const [],
    this.tvSeries = const [],
    this.episodes = const [],
    this.collections = const [],
    this.staff = const [],
    this.query
  });

  SearchResult from({
    List<ResourcePreview>? movies,
    List<ResourcePreview>? tvSeries,
    List<Episode>? episodes,
    List<ResourcePreview>? collections,
    List<StaffMember>? staff,
    String? query,
  }) => SearchResult(
    movies: movies ?? this.movies,
    tvSeries: tvSeries ?? this.tvSeries,
    episodes: episodes ?? this.episodes,
    collections: collections ?? this.collections,
    staff: staff ?? this.staff,
    query: query ?? this.query,
  );
}
