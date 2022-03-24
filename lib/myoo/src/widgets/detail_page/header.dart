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
  final String? title;
  /// Widget to display at the right-side of the poster
  /// Poster and widget will be spaced evenly
  final Widget? sideWidget;
  /// Height of the Header
  final double height;

  const DetailPageHeader({Key? key, required this.thumbnailURL, required this.posterURL, this.title, this.sideWidget, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          height: height,
          width: MediaQuery.of(context).size.width,
        ),
        Thumbnail(thumbnailURL: thumbnailURL),
        Positioned(
          top: 90,
          child: Row(
            children: [
              Poster(
                posterURL: posterURL,
                title: title,
                titleSize: 18,
                height: 220,
              ),
              sideWidget ?? Container(),
            ],
          ),
        ),
      ],
    );
 
}
