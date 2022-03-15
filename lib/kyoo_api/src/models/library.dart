import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
part 'library.g.dart';

/// A Librayr holds [Movie]s, [Collection]s, and/or [TVSeries]
@JsonSerializable()
class Library extends Ressource {
  /// The previews of the content of the library
  @JsonKey(defaultValue: [])
  List<IllustratedRessource> content;

  /// Default constructor
  Library({
    required int id,
    required String slug,
    required String name,
    required String overview,
    required this.content,
  }) : super(id: id, slug: slug, name: name, overview: overview);

  /// Unserialize [Library] from [JSONData]
  factory Library.fromJson(JSONData input) => _$LibraryFromJson(input);
}
