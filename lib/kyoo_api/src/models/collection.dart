import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/resource_preview.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection.g.dart';

/// A [Collection] groups related [Movie]s and/or [TVSeries]
@JsonSerializable(anyMap: true)
class Collection extends IllustratedResource {
  /// The content of the [Collection]
  @JsonKey(name: 'shows', defaultValue: [])
  List<ResourcePreview> content;

  /// Default constructor
  Collection({
    required this.content,
    required int id,
    required String slug,
    required String name,
    required String? overview,
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

  /// Unserialize [Collection] from [JSONData]
  factory Collection.fromJson(JSONData input) => _$CollectionFromJson(input);
}
