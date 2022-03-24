import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/widgets/poster.dart';
import 'package:myoo/myoo/src/widgets/thumbnail.dart';

/// Widget for the header of a Detail Page
/// It displays the thumbnail and the poster
class DetailPageHeader extends StatelessWidget {
  /// Url of the thumbnail to display
  final String? thumbnailURL;
  /// URL of the poster to display
  final String? posterURL;
  /// Title to display below poster
  final String title;
  /// Offset of the poster, compared to the center of the thumbnail
  final double? left;

  const DetailPageHeader({Key? key, required this.thumbnailURL, required this.posterURL, this.left, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 150),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Thumbnail(thumbnailURL: thumbnailURL),
          Positioned(
            bottom: -150,
            left: left,
            child: Poster(
              posterURL: posterURL,
              title: title,
              titleSize: 18,
              height: 220,
            )
          ),
        ],
      )
    );
 
}
