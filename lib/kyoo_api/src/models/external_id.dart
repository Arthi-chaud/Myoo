import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:myoo/kyoo_api/src/models/metadata_provider.dart';

part 'external_id.g.dart';

/// An [ExternalID] is a reference a [Movie] or [TVSeries]
/// This reference is a URL to a [MetadataProvider]'s Page about the [Movie] or [TVSeries]
@JsonSerializable()
class ExternalID {
  /// The identifiy of the provrder the id is from
  MetadataProvider provider;

  /// A URL to a page about the [Movie] or [TVSeries]
  @JsonKey(name: 'link')
  String externalURL;

  ExternalID({
    required this.provider,
    required this.externalURL,
  });

  factory ExternalID.fromJson(JSONData input) => _$ExternalIDFromJson(input);
}
