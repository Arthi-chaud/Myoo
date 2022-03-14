import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:myoo/kyoo_api/src/models/ressource.dart';

part 'illustrated_ressource.g.dart';

typedef IllustrationURL = String;

/// A [Ressource] that can have a Poster, and/or a thumbnail
@JsonSerializable()
class IllustratedRessource extends Ressource {
  /// URL of the Poster of the [Ressource], if it has one.
  @JsonKey(defaultValue: null)
  IllustrationURL? poster;

  /// URL of the Thumbnail of the [Ressource], if it has one.
  @JsonKey(defaultValue: null)
  IllustrationURL? thumbnail;

  /// Default constructor
  IllustratedRessource(
      {required int id,
      required String slug,
      required String name,
      required String overview,
      required this.poster,
      required this.thumbnail})
      : super(id: id, slug: slug, name: name, overview: overview);

  /// Unserialize [IllustratedRessource] from [JSONData]
  factory IllustratedRessource.fromJSON(JSONData input) =>
      _$IllustratedRessourceFromJson(input);
}
