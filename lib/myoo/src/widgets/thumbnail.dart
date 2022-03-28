import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/theme_data.dart';

/// Cached Image for a show's thumbnail
/// If said thumbnail doesnot exist, display transparent container
class Thumbnail extends StatelessWidget {
  /// URL of the thumbnail to display
  final String? thumbnailURL;

  /// Width of the thumbnail
  final double? width;

  /// Height of the thumbnail
  /// If null, will be deduced from width
  final double? height;

  const Thumbnail({Key? key, required this.thumbnailURL, this.width, this.height}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double? computedHeight = height ?? (width == null ? null : (width! * 9 / 16));
    Widget emptyThumbnail = SizedBox(
      height: computedHeight,
      width: width,
    );
    if (thumbnailURL == null) {
      return emptyThumbnail;
    }
    return CachedNetworkImage(
      imageUrl: thumbnailURL!,
      width: width,
      height: computedHeight,
      fit: BoxFit.cover,
      placeholder: (_, __) => emptyThumbnail,
      errorWidget: (_, __, ___) => emptyThumbnail
    );
  }
}
