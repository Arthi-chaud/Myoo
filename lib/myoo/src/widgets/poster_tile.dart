import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myoo/myoo/src/theme_data.dart';

/// Widget to display a [Movie]/[TVSeries]/[Collection] in a list
/// It is not used for an item's detail pages
class PosterTile extends StatelessWidget{
  /// URL of the image to display
  final String imageURL;

  /// Title of the poster
  final String title;

  /// Second title
  final String? subtitle;

  /// Default constructor
  const PosterTile({Key? key, required this.imageURL, required this.title, this.subtitle}) : super(key: key);

  static const double posterHeight = 200;

  Widget emptyPoster(BuildContext context) => SizedBox(
    height: posterHeight,
    width: posterHeight * 2 / 3,
    child: Container(
      color: getColorScheme(context).surface,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: imageURL,
          height: posterHeight,
          placeholder: (_, __) => emptyPoster(context),
          errorWidget: (_, __, ___) => emptyPoster(context)
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            title,
            style: TextStyle(
              color: getColorScheme(context).onPrimary
            ),
          ),
        ),
        Text(
          subtitle ?? '',
          style: TextStyle(
            color: getColorScheme(context).onPrimary,
            fontWeight: FontWeight.w100
          ),
        ),
      ]
    );
  }
}
