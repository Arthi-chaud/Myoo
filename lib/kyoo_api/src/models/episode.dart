import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:myoo/kyoo_api/src/models/video.dart';

part 'episode.g.dart';

/// An Object Representation of an [Episode], usually from a [Season], itself from a [TVSeries]. It is a [Video]
@JsonSerializable()
class Episode extends Video {
  /// Absolute index of the episode in the parent [TVSeries], if applicable
  @JsonKey(name: 'absoluteNumber')
  int? absoluteIndex;

  /// Index of the episode in the parent [Season], if applicable
  @JsonKey(name: 'episodeNumber')
  int? index;

  Episode({
    required int id,
    required String slug,
    required String name,
    required String overview,
    required DateTime firstAirDate,
    required this.absoluteIndex,
    required this.index,
    required String? poster,
    required String? thumbnail,
  }) : super(id: id, name: name, slug: slug, overview: overview, poster: poster, thumbnail: thumbnail, firstAirDate: firstAirDate);
  /// Unserialize [Episode] from [JSONData]
  factory Episode.fromJSON(JSONData input) => _$EpisodeFromJson(input);
}
