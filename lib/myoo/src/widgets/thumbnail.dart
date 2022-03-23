import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Cached Image for a show's thumbnail
/// If said thumbnail doesnot exist, display transparent container
class Thumbnail extends StatelessWidget {
  /// URL of the thumbnail to display
  final String? thumbnailURL;

  const Thumbnail({Key? key, required this.thumbnailURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Widget emptyThumbnail = Container(
      height: width * 9 / 16,
    );
    if (thumbnailURL == null) {
      return emptyThumbnail;
    }
    return CachedNetworkImage(
      imageUrl: thumbnailURL!,
      fit: BoxFit.cover,
      width: width,
      height: width * 9 / 16,
      errorWidget: (_, __, ___) => emptyThumbnail,
      placeholder: (_, __) => emptyThumbnail,
    );
  }
}
