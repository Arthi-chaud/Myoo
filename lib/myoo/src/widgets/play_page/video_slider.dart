import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/theme_data.dart';

/// Slider to view/controller video position in [PlayPage]
class VideoSlider extends StatelessWidget {
  /// Current position of the video
  final Duration position;
  /// Total duration of the video
  final Duration duration;

  /// Call back when the user interacts with the slider
  final void Function(Duration) onSlide;

  const VideoSlider({
    Key? key,
    required this.position,
    required this.duration,
    required this.onSlide
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: getColorScheme(context).secondary,
      value: position.inSeconds.toDouble(),
      max: duration.inSeconds.toDouble(),
      onChanged: (newSeconds) => onSlide(Duration(seconds: newSeconds.toInt()))
    );
  }
}
