import 'package:myoo/kyoo_api/src/models/episode.dart';
import 'package:myoo/kyoo_api/src/models/ressource.dart';

/// Representation of a [Season]. It holds [Episode]s and has a parent [TVSeries]
class Season extends IllustratedRessource {
  /// Index of the [Season] inthe parent [TVSeries]
  int index;
  /// Container of children [Episode]. 
  List<Episode> episodes;
}
