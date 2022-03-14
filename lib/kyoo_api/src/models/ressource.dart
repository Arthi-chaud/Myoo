import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';

part 'ressource.g.dart';

/// A resource is an Object from the Kyoo API that can be identified with an id, a slug, an overview and a name  (for humans)
@JsonSerializable()
class Ressource {
  /// Unique identifier from Kyoo's Database
  int id;

  /// String identifier
  Slug slug;

  /// A display name for the ressource
  @JsonKey(name: 'title')
  String name;

  /// A description of the ressource
  @JsonKey(defaultValue: "")
  String overview;

  /// Default constructor
  Ressource({
    required this.id,
    required this.slug,
    required this.name,
    required this.overview
  });

  /// Unserialize [Ressource] from [JSONData]
  factory Ressource.fromJSON(JSONData input) => _$RessourceFromJson(input);
}
