import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';

part 'ressource_preview.g.dart';

enum RessourcePreviewType {
  series, // Implicit 0
  movie, // Implicit 1
  collection, // Implicit 2
}

/// A [RessourcePreview] is mostly seen as a tile from the Home Page
@JsonSerializable()
class RessourcePreview extends IllustratedRessource {
  /// The type of the previwed [Ressource]
  @JsonKey(readValue: _getTypeFromJson)
  final RessourcePreviewType type;

  /// Default constructor
  RessourcePreview({
    required this.type,
    required int id,
    required String slug,
    required String name,
    required String overview,
    String? poster,
    String? thumbnail
  }) : super(id: id, slug: slug, name: name, overview: overview, poster: poster, thumbnail: thumbnail);
  /// Unserialize [RessourcePreview] from [JSONData]
  factory RessourcePreview.fromJson(JSONData input) => _$RessourcePreviewFromJson(input);

  static String _getTypeFromJson(Map input, String type) {
    if (input.containsKey(type)) {
      return RessourcePreviewType.values.elementAt(input[type]).name;
    }
    if (input['isMovie']) {
      return RessourcePreviewType.movie.name;
    }
    return RessourcePreviewType.series.name;
  }
}
