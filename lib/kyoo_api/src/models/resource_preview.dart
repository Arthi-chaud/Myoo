import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';

part 'resource_preview.g.dart';

enum ResourcePreviewType {
  series, // Implicit 0
  movie, // Implicit 1
  collection, // Implicit 2
}

/// A [ResourcePreview] is mostly seen as a tile from the Home Page
@JsonSerializable()
class ResourcePreview extends IllustratedResource {
  /// The type of the previwed [Resource]
  @JsonKey(readValue: _getTypeFromJson)
  final ResourcePreviewType type;

  /// Default constructor
  ResourcePreview({
    required this.type,
    required int id,
    required String slug,
    required String name,
    required String overview,
    String? poster,
    String? thumbnail
  }) : super(
    id: id,
    slug: slug,
    name: name,
    overview: overview,
    poster: poster,
    thumbnail: thumbnail
  );

  /// Unserialize [ResourcePreview] from [JSONData]
  factory ResourcePreview.fromJson(JSONData input) =>
      _$ResourcePreviewFromJson(input);

  static String _getTypeFromJson(Map input, String type) {
    if (input.containsKey(type)) {
      return ResourcePreviewType.values.elementAt(input[type]).name;
    }
    if (input['isMovie']) {
      return ResourcePreviewType.movie.name;
    }
    return ResourcePreviewType.series.name;
  }
}
