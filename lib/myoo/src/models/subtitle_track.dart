import 'package:subtitle/subtitle.dart';
import 'package:video_player/video_player.dart';

/// Simple class to implement subtitle class for video player
class SubtitleTrack implements ClosedCaptionFile {
  final List<Caption> _captions;

  const SubtitleTrack(List<Caption> captions) : _captions = captions;

  @override
  List<Caption> get captions => _captions;

  static Future<SubtitleTrack> fromURL(String subURL) {
    return SubtitleProvider
    .fromNetwork(Uri.parse(subURL))
    .getSubtitle()
    .then(
      (value) {
        try {
          var a = SubtitleTrack(
            SubtitleParser(value)
            .parsing()
            .map(
              (subtitle) => Caption(
                number: subtitle.index,
                start: subtitle.start,
                end: subtitle.end,
                text: subtitle.data
              )
            ).toList()
          );
          return a;
        } catch (e) {
          return const SubtitleTrack([]);
        }
      }
    ).onError((error, stackTrace) => const SubtitleTrack([]));
  }
}
