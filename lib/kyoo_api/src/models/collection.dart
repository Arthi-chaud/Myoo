import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/ressource_preview.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection.g.dart';

/// A [Collection] groups related [Movie]s and/or [TVSeries]
@JsonSerializable(anyMap: true)
class Collection extends IllustratedRessource {
  /// The content of the [Collection]
  @JsonKey(name: 'shows')
  List<RessourcePreview> content;

  /// Default constructor
  Collection({
    required this.content,
    required int id,
    required String slug,
    required String name,
    required String overview,
    required String? poster,
    required String? thumbnail,
  }) : super(id: id, name: name, slug: slug, overview: overview, poster: poster, thumbnail: thumbnail);

  /// Unserialize [Collection] from [JSONData]
  factory Collection.fromJSON(JSONData input) => _$CollectionFromJson(input);
}
