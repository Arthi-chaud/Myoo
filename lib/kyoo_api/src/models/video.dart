import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/src/models/illustrated_ressource.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';

part 'video.g.dart';

/// A [IllustratedRessource] that has duration and an air date
@JsonSerializable()
class Video extends IllustratedRessource {
  /// Date of the Episode's first air, or day of release
  DateTime firstAirDate;

  /// Default constructor
  Video({
    required this.firstAirDate,
    required int id,
    required String slug,
    required String name,
    required String overview,
    required String? poster,
    required String? thumbnail,
  }) : super(id: id, name: name, slug: slug, overview: overview, poster: poster, thumbnail: thumbnail);

  /// Unserialize [Video] from [JSONData]
  factory Video.fromJSON(JSONData input) => _$VideoFromJson(input);
}
