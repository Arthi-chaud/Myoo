import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/src/models/genre.dart';
import 'package:myoo/kyoo_api/src/models/trailer_url.dart';
import 'package:myoo/kyoo_api/src/models/video.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';

part 'movie.g.dart';

/// A Movie is a [Video] that has [Genre]s
@JsonSerializable()
class Movie extends Video {
  /// List of genres to describe a [Movie]
  @JsonKey(fromJson: GenresParsing.fromJSON)
  List<Genre> genres;

  /// External URL to the [Movie]'s trailer
  @JsonKey(defaultValue: null)
  TrailerURL? trailer;

  /// Default constructor
  Movie({
    required int id,
    required String slug,
    required String name,
    required String overview,
    required DateTime firstAirDate,
    required String? poster,
    required String? thumbnail,
    required this.genres,
    required this.trailer,
  }) : super(id: id, slug: slug, name: name, overview: overview, firstAirDate: firstAirDate, poster: poster, thumbnail: thumbnail);

  /// Unserialize [Movie] from [JSONData]
  factory Movie.fromJSON(JSONData input) => _$MovieFromJson(input);
}
