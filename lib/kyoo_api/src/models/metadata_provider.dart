import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';

part 'metadata_provider.g.dart';

/// A Class to get access to external info about other [Resource]
@JsonSerializable()
class MetadataProvider extends Resource {
  /// A URL to the lgo of the [MetadataProvider]
  String logo;

  MetadataProvider({
    required int id,
    required Slug slug,
    required String name,
    required this.logo
  }) : super(id: id, slug: slug, name: name, overview: null);
  
  factory MetadataProvider.fromJson(JSONData input) => _$MetadataProviderFromJson(input);
}
