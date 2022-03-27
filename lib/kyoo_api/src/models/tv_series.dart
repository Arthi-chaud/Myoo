import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/src/models/genre.dart';
import 'package:myoo/kyoo_api/src/models/illustrated_resource.dart';
import 'package:myoo/kyoo_api/src/models/resource.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:myoo/kyoo_api/src/models/season.dart';
import 'package:myoo/kyoo_api/src/models/studio.dart';
import 'package:myoo/kyoo_api/src/models/trailer_url.dart';

part 'tv_series.g.dart';

/// A [TVSeries] holds multiple [Season]s or a single [Season]
@JsonSerializable()
class TVSeries extends IllustratedResource {
  /// List of [Genre] to describe the [TVSeries]
  @JsonKey(fromJson: GenresParsing.fromJson)
  final List<Genre> genres;

  /// List of [Season] of the [TVSeries]
  @JsonKey(defaultValue: [])
  final List<Season> seasons;

  /// External URL to the [TVSeries]'s trailer
  @JsonKey(name: 'trailerUrl')
  final TrailerURL? trailer;

  /// The name of the studio who produced the [TVSeries]
  @JsonKey(fromJson: StudioParsing.fromJson, name: 'studio')
  final String? studio;

  /// Usually, the air date of the first episode
  @JsonKey(name: 'startAir')
  final DateTime? releaseDate;

  /// Usually, the air date of the last episode
  @JsonKey(name: 'endAir')
  final DateTime? endDate;

  /// Default Constructor
  const TVSeries({
    required this.genres,
    required this.trailer,
    required this.seasons,
    required int id,
    required String slug,
    required String name,
    required String overview,
    required this.studio,
    required this.releaseDate,
    required this.endDate,
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

  factory TVSeries.fromJson(JSONData input) => _$TVSeriesFromJson(input);
}
