import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/theme_data.dart';

/// Widget to display a poster, with optional title
class Poster extends StatelessWidget {
  /// URL of the poster, if null, displays placeholder
  final String? posterURL;
  /// title to be displayed below poster
  final String title;
  /// Optional text below title
  final String? subtitle;
  /// Default size of the title
  final double titleSize;
  const Poster({Key? key, this.posterURL, required this.title, this.subtitle, this.titleSize = textSize}) : super(key: key);

  static const double posterHeight = 150;
  static const double posterWidth = posterHeight * 2 / 3;
  static const double textSize = 14;

  static const double _roundedEdges = 4;

  Widget _emptyPoster(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: getColorScheme(context).surface,
      border: Border.all(
        color: getColorScheme(context).surface,
      ),
      borderRadius: BorderRadius.circular(_roundedEdges),
    ),
    height: posterHeight,
    width: posterWidth,
  );

  @override
  Widget build(BuildContext context) =>
    Column(
      children: [
        posterURL != null ? ClipRRect(
          borderRadius: BorderRadius.circular(_roundedEdges),
          child: CachedNetworkImage(
            imageUrl: posterURL!,
            height: posterHeight,
            width: posterWidth,
            fit: BoxFit.cover,
            placeholder: (_, __) => _emptyPoster(context),
            errorWidget: (_, __, ___) => _emptyPoster(context)
          )
        ) : _emptyPoster(context),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
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
        ),
        subtitle != null ? Text(
          subtitle!,
          style: TextStyle(
            fontSize: Poster.textSize * 0.8,
            overflow: TextOverflow.ellipsis,
            color: getColorScheme(context).onPrimary,
            fontWeight: FontWeight.w200
          ),
        ) : Container()
      ]
    );
}
