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

  const DetailPageHeader({Key? key, required this.thumbnailURL, required this.posterURL, this.title, this.sideWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Padding(
      padding: EdgeInsets.only(bottom: (sideWidget == null) ? 130 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topLeft,
            children: [
              Thumbnail(thumbnailURL: thumbnailURL),
              Positioned(
                top: sideWidget == null ? 90 : 150,
                left: sideWidget == null ? 0 : -90,
                width: MediaQuery.of(context).size.width,
                child: Poster(
                  posterURL: posterURL,
                  title: title,
                  titleSize: 18,
                  height: 220,
                ),
              ),
            ],
          ),
          if (sideWidget != null)
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: sideWidget
            ),
          )
        ],
      ),
    );
 
}
