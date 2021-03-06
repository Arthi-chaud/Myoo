import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/resource_preview.dart';
part 'library.g.dart';

/// A Librayr holds [Movie]s, [Collection]s, and/or [TVSeries]
@JsonSerializable()
class Library extends Resource {
  /// The previews of the content of the library
  @JsonKey(defaultValue: [])
  List<ResourcePreview> content;

  /// Default constructor
  Library({
    required int id,
    required String slug,
    required String name,
    required this.content,
  }) : super(id: id, slug: slug, name: name, overview: null);

  /// Unserialize [Library] from [JSONData]
  factory Library.fromJson(JSONData input) => _$LibraryFromJson(input);
}
