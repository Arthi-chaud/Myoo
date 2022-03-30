import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/theme_data.dart';
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
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var minDim = min(screenSize.height, screenSize.width);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Container(
            width: minDim,
            child: Thumbnail(thumbnailURL: thumbnailURL),
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [getColorScheme(context).background, Colors.transparent],
                stops: const [0, 0.5],
                begin: Alignment.bottomCenter,
                end: Alignment.center
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: minDim * 0.4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Poster(
                    posterURL: posterURL,
                    title: title,
                    titleSize: 18,
                    height: 220,
                  )
              ),
              sideWidget != null
              ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 70, right: 10),
                  child: sideWidget!
                )
              )
              : Container()
            ],
          )
        ),
      ],
    );
  }
}
