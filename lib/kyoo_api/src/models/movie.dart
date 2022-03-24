import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/src/models/genre.dart';
import 'package:myoo/kyoo_api/src/models/studio.dart';
import 'package:myoo/kyoo_api/src/models/trailer_url.dart';
import 'package:myoo/kyoo_api/src/models/video.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:myoo/kyoo_api/src/models/resource.dart';

part 'movie.g.dart';

/// A Movie is a [Video] that has [Genre]s
@JsonSerializable()
class Movie extends Video {
  /// List of genres to describe a [Movie]
  @JsonKey(fromJson: GenresParsing.fromJson, defaultValue: [])
  final List<Genre> genres;

  /// External URL to the [Movie]'s trailer
  @JsonKey(defaultValue: null)
  final TrailerURL? trailer;

  /// Name of the studio
  @JsonKey(fromJson: StudioParsing.fromJson)
  final String? studio;

  /// Default constructor
  const Movie({
    required int id,
    required String slug,
    required String name,
    required String overview,
    required DateTime releaseDate,
    String? poster,
    String? thumbnail,
    required this.studio,
    required this.genres,
    required this.trailer,
  }) : super(
    id: id,
    slug: slug,
    name: name,
    overview: overview,
    releaseDate: releaseDate,
    poster: poster,
    thumbnail: thumbnail
  );

  /// Unserialize [Movie] from [JSONData]
  factory Movie.fromJson(JSONData input) => _$MovieFromJson(input);
}
