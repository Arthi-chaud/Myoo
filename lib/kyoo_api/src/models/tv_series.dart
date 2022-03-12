import 'package:myoo/kyoo_api/src/models/genre.dart';
import 'package:myoo/kyoo_api/src/models/illustrated_ressource.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:myoo/kyoo_api/src/models/season.dart';

/// A [TVSeries] holds multiple [Season]s or a single [Season]
class TVSeries extends IllustratedRessource {
  /// List of [Genre] to describe the [TVSeries]
  List<Genre> genres;
  /// List of [Season] of the [TVSeries]
  List<Season> seasons;
  
  TVSeries.fromJSON(JSONData input):
    genres = GenresParsing.fromJSON(input),
    seasons = (input['seasons'] as List).map(
      (season) => Season.fromJSON(season)
    ).toList(),
    super.fromJSON(input);
}
