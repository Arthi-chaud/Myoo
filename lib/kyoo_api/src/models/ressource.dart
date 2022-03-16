import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';

part 'ressource.g.dart';

/// A resource is an Object from the Kyoo API that can be identified with an id, a slug, an overview and a name  (for humans)
@JsonSerializable()
class Ressource {
  /// Unique identifier from Kyoo's Database
  final int id;

  /// String identifier
  final Slug slug;

  /// A display name for the ressource
  @JsonKey(readValue: getTitleFromJSON)
  final String name;

  /// A description of the ressource
  @JsonKey(defaultValue: "")
  final String overview;

  /// Default constructor
  const Ressource({
    required this.id,
    required this.slug,
    required this.name,
    required this.overview
  });
  /// Get the [Ressource]'s title from JSON. It is usually in 'title', but sometimes in 'name'
  static Object? getTitleFromJSON(Map<dynamic, dynamic> input, String _) {
    if (input.containsKey('name')) {
      return input['name'];
    }
    return input['title'];
  }

  /// Unserialize [Ressource] from [JSONData]
  factory Ressource.fromJson(JSONData input) => _$RessourceFromJson(input);
}
