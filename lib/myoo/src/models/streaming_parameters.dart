import 'package:myoo/kyoo_api/kyoo_api.dart';

import 'package:myoo/kyoo_api/src/models/track.dart';

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

  /// The subtitle track to use
  final Track? currentSubtitlesTrack;

  /// The audio track to use
  final Track? currentAudioTrack;

  const StreamingParameters({
    required this.method,
    required this.isPlaying,
    required this.currentPosition,
    required this.totalDuration,
    required this.currentSubtitlesTrack,
    required this.currentAudioTrack
  });

  StreamingParameters.init():
    method = StreamingMethod.direct,
    isPlaying = true,
    currentPosition = Duration.zero,
    totalDuration = null,
    currentAudioTrack = null,
    currentSubtitlesTrack = null;

  /// Creates new instance of [StreamingParameters], and overriding fields with given values
  StreamingParameters withParams({
    StreamingMethod? method,
    bool? isPlaying,
    List<String>? subtitlesTracks,
    Duration? currentPosition,
    Duration? totalDuration,
    Track? currentSubtitlesTrack,
    Track? currentAudioTrack,
  }) => StreamingParameters(
    currentAudioTrack: currentAudioTrack ?? this.currentAudioTrack,
    method: method ?? this.method,
    isPlaying: isPlaying ?? this.isPlaying,
    currentPosition: currentPosition ?? this.currentPosition,
    totalDuration: totalDuration ?? this.totalDuration,
    currentSubtitlesTrack: currentSubtitlesTrack ?? this.currentSubtitlesTrack,
  );
}
