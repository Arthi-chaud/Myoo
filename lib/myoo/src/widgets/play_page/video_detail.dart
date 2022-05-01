import 'package:flutter/widgets.dart';
import 'package:myoo/kyoo_api/src/models/watch_item.dart';
import 'package:myoo/myoo/src/widgets/poster.dart';

/// Widget to display a plyaing [WatchItem]'s poster, title, name of episode if applicable, duration and play position
class VideoDetail extends StatelessWidget {
  /// [WatchItem] to display the details of
  final WatchItem video;
  /// Current position of the play
  final Duration position;
  /// Duration of the [WatchItem]
  final Duration duration;
  const VideoDetail({Key? key, required this.video, required this.position, required this.duration}) : super(key: key);

  /// Formats a [Duration] to display seconds and minutes, but exclude hours if zero
  String formatDuration(Duration duration) {
    String timeString = duration.toString().split('.').first;
    if (timeString.startsWith('0:')) {
      timeString = timeString.substring(2);
    }
    return timeString;
  }

  /// Format the title to display
  String getVideoTitle() {
    if (video.parentSeasonIndex != null && video.index != null) {
      return "${video.parentName}: S${video.parentSeasonIndex} - E${video.index}";
    }
    return video.parentName;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Poster(posterURL: video.poster, height: 80),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getVideoTitle(),
                  overflow: TextOverflow.ellipsis, maxLines: 2
                ),
                if (video.name != video.parentName)
                Text(
                  video.name,
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  "${formatDuration(position)} - ${formatDuration(duration)}",
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
