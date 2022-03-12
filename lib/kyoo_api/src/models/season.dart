import 'package:myoo/kyoo_api/src/models/episode.dart';
import 'package:myoo/kyoo_api/src/models/illustrated_ressource.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';

/// Representation of a [Season]. It holds [Episode]s and has a parent [TVSeries]
class Season extends IllustratedRessource {
  /// Index of the [Season] in the parent [TVSeries]
  int index;
  /// Container of children [Episode]. 
  List<Episode> episodes;

  Season.fromJSON(JSONData input):
    index = input['seasonNumber'],
    episodes = (input['episodes'] as List)
      .map((episode) => Episode.fromJSON(episode))
      .toList(),
    super.fromJSON(input);
}
