import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/theme_data.dart';

/// Widget to display a poster, with optional title
class Poster extends StatelessWidget {
  /// URL of the poster, if null, displays placeholder
  final String? posterURL;
  /// title to be displayed below poster
  final String title;
  /// Default size of the title
  final double titleSize;
  const Poster({Key? key, this.posterURL, required this.title, this.titleSize = textSize}) : super(key: key);

  static const double posterHeight = 150;
  static const double posterWidth = posterHeight * 2 / 3;
  static const double textSize = 14;

  Widget _emptyPoster(BuildContext context) => SizedBox(
    height: posterHeight,
    width: posterWidth,
    child: Container(
      color: getColorScheme(context).surface,
    ),
  );

  @override
  Widget build(BuildContext context) {
    if (posterURL == null) {
      return _emptyPoster(context);
    }
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: CachedNetworkImage(
            imageUrl: posterURL!,
            height: posterHeight,
            width: posterWidth,
            fit: BoxFit.cover,
            placeholder: (_, __) => _emptyPoster(context),
            errorWidget: (_, __, ___) => _emptyPoster(context)
          )
        ),
        SizedBox(
          width: Poster.posterWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleSize,
                color: getColorScheme(context).onPrimary
              ),
            ),
          ),
        )
      ]
    );
  }
}
