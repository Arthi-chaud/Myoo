import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/src/models/episode.dart';
import 'package:myoo/kyoo_api/src/models/illustrated_ressource.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:myoo/kyoo_api/src/models/ressource.dart';

part 'season.g.dart';

/// Representation of a [Season]. It holds [Episode]s and has a parent [TVSeries]
@JsonSerializable()
class Season extends IllustratedRessource {
  /// Index of the [Season] in the parent [TVSeries]
  @JsonKey(name: 'seasonNumber')
  int index;

  /// Container of children [Episode].
  @JsonKey(defaultValue: [])
  List<Episode> episodes;

  /// Default constructor
  Season({
    required this.index,
    required this.episodes,
    required int id,
    required String slug,
    required String name,
    required String overview,
    required String? poster,
    required String? thumbnail,
  }) : super(id: id, name: name, slug: slug, overview: overview, poster: poster, thumbnail: thumbnail);

  /// Unserialize [Season] from [JSONData]
  factory Season.fromJSON(JSONData input) => _$SeasonFromJson(input);
}
