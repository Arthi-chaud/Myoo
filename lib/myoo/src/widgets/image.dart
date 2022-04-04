import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
/// An image that'll be download from a Kyoo Server
/// No cache system
class MyooImage extends StatelessWidget {
  /// The URL of the image to download
  final String imageURL;

  /// [Widget] to display while the image is loading
  final Widget Function(BuildContext)? placeholder;

  /// Dimensions of the image
  final double? height;
  final double? width;

  const MyooImage(this.imageURL, {Key? key, this.placeholder, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageURL,
      placeholder: (context, _) => placeholder?.call(context) ?? Container(),
      height: height,
      width: width,
    );
  }
}
