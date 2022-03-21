import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:myoo/kyoo_api/src/models/resource.dart';

part 'illustrated_resource.g.dart';

typedef IllustrationURL = String;

/// A [Resource] that can have a Poster, and/or a thumbnail
@JsonSerializable()
class IllustratedResource extends Resource {
  /// URL of the Poster of the [Resource], if it has one.
  @JsonKey(defaultValue: null)
  final IllustrationURL? poster;

  /// URL of the Thumbnail of the [Resource], if it has one.
  @JsonKey(defaultValue: null)
  final IllustrationURL? thumbnail;

  /// Default constructor
  const IllustratedResource(
      {required int id,
      required String slug,
      required String name,
      required String overview,
      required this.poster,
      required this.thumbnail})
      : super(id: id, slug: slug, name: name, overview: overview);

  /// Unserialize [IllustratedResource] from [JSONData]
  factory IllustratedResource.fromJson(JSONData input) =>
      _$IllustratedResourceFromJson(input);
}
