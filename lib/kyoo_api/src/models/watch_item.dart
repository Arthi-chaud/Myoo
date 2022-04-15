import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/track.dart';

part 'watch_item.g.dart';

/// A [WatchItem] is a [Video] with metadata related to its context
/// I.e: Next, or previous [Episode], [AudioTrack], [SubtitleTrack] etc
@JsonSerializable()
class WatchItem extends Video {
  /// The [Episode] before current [WatchItem]
  /// If current [WatchItem] is a [Movie], this will be null
  final Video? previous;
   /// The [Episode] folliwing current [WatchItem]
  /// If current [WatchItem] is a [Movie], this will be null
  final Video? next;
  /// The name of the parent [TVSeries]
  /// If current [WatchItem] is a [Movie], this will be the same as its title
  @JsonKey(name: 'showTitle')
  final String parentName;
  /// The index of the [Season] if [WatchItem] is an [Episode]
  @JsonKey(name: 'seasonNumber')
  final int? parentSeasonIndex;
  /// The index of the [Episode] in the [Season] if [WatchItem] is an [Episode]
  @JsonKey(name: 'episodeNumber')
  final int? index;

  @JsonKey(name: 'subtitles', defaultValue: [])
  final List<Track> subtitleTracks;

  const WatchItem({
    required this.previous,
    required this.next,
    required this.parentName,
    required this.parentSeasonIndex,
    required this.index,
    required this.subtitleTracks,
    required String? poster,
    required String? thumbnail,
    required DateTime? releaseDate,
    required String slug,
    required String name,
  }) : super(releaseDate: releaseDate, id: 0, slug: slug, name: name, overview: null, poster: poster, thumbnail: thumbnail);

  /// Unserialize [WatchItem] from [JSONData]
  factory WatchItem.fromJson(JSONData input) => _$WatchItemFromJson(input);
}
