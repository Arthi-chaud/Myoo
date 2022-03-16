import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/src/models/genre.dart';
import 'package:myoo/kyoo_api/src/models/illustrated_ressource.dart';
import 'package:myoo/kyoo_api/src/models/ressource.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:myoo/kyoo_api/src/models/season.dart';
import 'package:myoo/kyoo_api/src/models/trailer_url.dart';

part 'tv_series.g.dart';

/// A [TVSeries] holds multiple [Season]s or a single [Season]
@JsonSerializable()
class TVSeries extends IllustratedRessource {
  /// List of [Genre] to describe the [TVSeries]
  @JsonKey(fromJson: GenresParsing.fromJson)
  final List<Genre> genres;

  /// List of [Season] of the [TVSeries]
  @JsonKey(defaultValue: [])
  final List<Season> seasons;

  /// External URL to the [TVSeries]'s trailer
  final TrailerURL trailer;

  /// Default Constructor
  const TVSeries({
    required this.genres,
    required this.trailer,
    required this.seasons,
    required int id,
    required String slug,
    required String name,
    required String overview,
    String? poster,
    String? thumbnail,
  }) : super(id: id, name: name, slug: slug, overview: overview, poster: poster, thumbnail: thumbnail);

  factory TVSeries.fromJson(JSONData input) => _$TVSeriesFromJson(input);
}
