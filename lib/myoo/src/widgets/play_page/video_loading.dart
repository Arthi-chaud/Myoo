import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/widgets/loading_widget.dart';
import 'package:myoo/myoo/src/widgets/thumbnail.dart';

/// Widget to display in [PlayPage], while video is loading
class VideoLoadingWidget extends StatelessWidget {

  /// The URL of the thumbnail to display
  final String? thumbnailURL;

  const VideoLoadingWidget({Key? key, required this.thumbnailURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children:  [
        DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            color: getColorScheme(context).background.withAlpha(200)
          ),
          child: Thumbnail(
            thumbnailURL: thumbnailURL,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        const LoadingWidget(),
      ]
    );
  }
}
