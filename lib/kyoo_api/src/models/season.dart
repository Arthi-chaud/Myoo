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
  final int index;

  /// Container of children [Episode].
  @JsonKey(defaultValue: [])
  final List<Episode> episodes;

  /// Default constructor
  const Season({
    required this.index,
    required this.episodes,
    required int id,
    required String slug,
    required String name,
    required String overview,
    String? poster,
    String? thumbnail,
  }) : super(id: id, name: name, slug: slug, overview: overview, poster: poster, thumbnail: thumbnail);

  /// Copy constructor to apply episodes
  Season copyWith({required List<Episode> episodes}) => 
    Season(index: index, episodes: episodes, id: id, slug: slug, name: name, overview: overview);

  /// Unserialize [Season] from [JSONData]
  factory Season.fromJson(JSONData input) => _$SeasonFromJson(input);
}
