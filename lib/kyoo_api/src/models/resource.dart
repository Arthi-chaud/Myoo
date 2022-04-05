import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';

part 'resource.g.dart';

/// A resource is an Object from the Kyoo API that can be identified with an id, a slug, an overview and a name  (for humans)
@JsonSerializable()
class Resource {
  /// Unique identifier from Kyoo's Database
  final int id;

  /// String identifier
  final Slug slug;

  /// A display name for the Resource
  @JsonKey(readValue: getTitleFromJSON)
  final String name;

  /// A description of the Resource
  final String? overview;

  /// Default constructor
  const Resource({
    required this.id,
    required this.slug,
    required this.name,
    required this.overview
  });

  /// Get the [Resource]'s title from JSON. It is usually in 'title', but sometimes in 'name'
  static String? getTitleFromJSON(Map<dynamic, dynamic> input, _) {
    if (input.containsKey('name')) {
      return input['name'];
    }
    return input['title'];
  }

  /// Unserialize [Resource] from [JSONData]
  factory Resource.fromJson(JSONData input) => _$ResourceFromJson(input);
}
