import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'dart:io' show Platform;

/// The parameters of the streaming
class StreamingParameters {
  /// The way the video is being streamed
  /// See [StreamingMethod]
  final StreamingMethod method;

  /// Is the video playing or paused
  final bool isPlaying;

  /// The current position in the video
  final Duration currentPosition;

  /// The length of the video
  final Duration? totalDuration;

  /// A list of url for availables subtitles
  final List<String>? subtitlesTracks;

  /// The Url of the subtitle track to use
  final String? currentSubtitlesTrack;

  /// TODO Manage audio tracks
  const StreamingParameters({
    required this.method,
    required this.isPlaying,
    required this.subtitlesTracks,
    required this.currentPosition,
    required this.totalDuration,
    required this.currentSubtitlesTrack,
  });

  StreamingParameters.init():
    method = Platform.isIOS ? StreamingMethod.transmux : StreamingMethod.direct,
    isPlaying = true,
    subtitlesTracks = null,
    currentPosition = Duration.zero,
    totalDuration = null,
    currentSubtitlesTrack = null;

  /// Creates new instance of [StreamingParameters], and overriding fields with given values
  StreamingParameters withParams({
    StreamingMethod? method,
    bool? isPlaying,
    List<String>? subtitlesTracks,
    Duration? currentPosition,
    Duration? totalDuration,
    String? currentSubtitlesTrack,
  }) => StreamingParameters(
    method: method ?? this.method,
    isPlaying: isPlaying ?? this.isPlaying,
    subtitlesTracks: subtitlesTracks ?? this.subtitlesTracks,
    currentPosition: currentPosition ?? this.currentPosition,
    totalDuration: totalDuration ?? this.totalDuration,
    currentSubtitlesTrack: currentSubtitlesTrack ?? this.currentSubtitlesTrack,
  );
}
