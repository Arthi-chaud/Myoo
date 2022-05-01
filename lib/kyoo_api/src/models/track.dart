import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';

part 'track.g.dart';

/// A [Track] is a 'layer' of a [WatchItem], it can be visual like subtitles or audio
@JsonSerializable()
class Track extends Resource {
  /// A name the user can understand to identify the track
  /// Same as [name]
  final String displayName;

  /// A 3-char string to identify the track's language
  final String language;

  /// Identifier of the [Track]'s codec
  final String codec;

  /// Is the track the default track
  final bool isDefault;

  /// Is the track forced
  final bool isForced;

  /// Index of the track, useful if some tracks are similar
  @JsonKey(name: 'trackIndex')
  final int index;

  Track({
    required this.displayName,
    required this.language,
    required this.codec,
    required this.isDefault,
    required this.isForced,
    required this.index,
    required int id,
    required Slug slug,
  }) : super(id: id, slug: slug, name: displayName, overview: null);

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
}
