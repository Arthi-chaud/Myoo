import 'package:myoo/kyoo_api/kyoo_api.dart';

/// A [Collection] groups related [Movie]s and/or [TVSeries]
class Collection extends IllustratedRessource {
  /// The content of the [Collection] that are [Movie]s
  List<Movie> movies;
  ////TODO For now, Collection can only content movies. However, it shoudl be able to hold TVSeries

  Collection.fromJSON(JSONData input):
    movies = (input['shows'] as List)
      .map((e) => Movie.fromJSON(e))
      .toList(),
    super.fromJSON(input);
}
