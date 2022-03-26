import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/theme_data.dart';

/// Cached Image for a show's thumbnail
/// If said thumbnail doesnot exist, display transparent container
class Thumbnail extends StatelessWidget {
  /// URL of the thumbnail to display
  final String? thumbnailURL;

  const Thumbnail({Key? key, required this.thumbnailURL}) : super(key: key);

  /// Get the heigth of the thumbnail, using the width of the media
  static double height(BuildContext context) => MediaQuery.of(context).size.width * 9 / 16;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Widget emptyThumbnail = Container(
      height: height(context),
    );
    if (thumbnailURL == null) {
      return emptyThumbnail;
    }
    return Container(
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [getColorScheme(context).background, Colors.transparent],
          stops: const [0, 0.5],
          begin: Alignment.bottomCenter,
          end: Alignment.center
        )
      ),
      child: CachedNetworkImage(
        imageUrl: thumbnailURL!,
        fit: BoxFit.cover,
        width: width,
        height: width * 9 / 16,
        errorWidget: (_, __, ___) => emptyThumbnail,
        placeholder: (_, __) => emptyThumbnail,
      )
    );
  }
}
