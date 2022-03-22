import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:myoo/myoo/src/theme_data.dart';

/// Widget to display a [Movie]/[TVSeries]/[Collection] in a list
/// It is not used for an item's detail pages
class PosterTile extends StatelessWidget{
  /// URL of the image to display
  /// If null, display a empty, grey poster
  final String? imageURL;

  /// Title of the poster
  final String title;

  /// Second title
  final String? subtitle;

  /// Default constructor
  const PosterTile({Key? key, required this.imageURL, required this.title, this.subtitle}) : super(key: key);

  static const double posterHeight = 150;
  static const double posterWidth = posterHeight * 2 /3;

  static const double textSize = 14;

  Widget emptyPoster(BuildContext context) => SizedBox(
    height: posterHeight,
    width: posterWidth,
    child: Container(
      color: getColorScheme(context).surface,
    ),
  );

  @override
  Widget build(BuildContext context) =>
    Column(
      children: [
        imageURL != null ?
          CachedNetworkImage(
            imageUrl: imageURL!,
            height: posterHeight,
            width: posterWidth,
            fit: BoxFit.cover,
            placeholder: (_, __) => emptyPoster(context),
            errorWidget: (_, __, ___) => emptyPoster(context)
          )
        : emptyPoster(context),
        SizedBox(
          width: posterWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: textSize,
                color: getColorScheme(context).onPrimary
              ),
            ),
          ),
        ),
        Text(
          subtitle ?? '',
          style: TextStyle(
            fontSize: textSize * 0.8,
            overflow: TextOverflow.ellipsis,
            color: getColorScheme(context).onPrimary,
            fontWeight: FontWeight.w200
          ),
        ),
      ]
    );
}
