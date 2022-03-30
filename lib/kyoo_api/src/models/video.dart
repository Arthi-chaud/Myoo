import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/src/models/illustrated_resource.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:myoo/kyoo_api/src/models/resource.dart';

part 'video.g.dart';

/// Enumeration of methods to stream a video
enum StreamingMethod {
  direct,
  transmux,
  ///transcode
}

/// A [IllustratedResource] that has duration and an air date
@JsonSerializable()
class Video extends IllustratedResource {
  /// Date of the [Video]'s first air, or day of release
  @JsonKey(readValue: getReleaseDateFromJSON)
  final DateTime? releaseDate;

  /// Default constructor
  const Video({
    required this.releaseDate,
    required int id,
    required String slug,
    required String name,
    required String overview,
    String? poster,
    String? thumbnail,
  }) : super(
    id: id,
    name: name,
    slug: slug,
    overview: overview,
    poster: poster,
    thumbnail: thumbnail
  );

  /// Unserialize [Video] from [JSONData]
  factory Video.fromJson(JSONData input) => _$VideoFromJson(input);

  /// Get the [Video]'s Release Date from JSON. It is usually in 'releaseDate', but sometimes in 'startAir'
  static Object? getReleaseDateFromJSON(Map<dynamic, dynamic> input, String _) {
    if (input.containsKey('releaseDate')) {
      return input['releaseDate'];
    }
    return input['startAir'];
  }
}
