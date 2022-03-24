import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/theme_data.dart';

/// Widget to display a poster, with optional title
class Poster extends StatelessWidget {
  /// URL of the poster, if null, displays placeholder
  final String? posterURL;
  /// Height of the poster, width will be deduced from it
  final double height;
  /// title to be displayed below poster
  final String? title;
  /// Optional text below title
  final String? subtitle;
  /// Size of the title
  final double titleSize;
  const Poster({Key? key, this.posterURL, this.title, this.subtitle, this.titleSize = defaultTextSize, this.height = defaultPosterHeight}) : super(key: key);

  static const double defaultPosterHeight = 150;
  static const double defaultPosterWidth = defaultPosterHeight * 2 / 3;
  static const double defaultTextSize = 14;

  static const double _roundedEdges = 6;

  /// Width deduced from provided height
  double get width => height * 2 / 3;

  Widget _emptyPoster(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: getColorScheme(context).surface,
      border: Border.all(
        color: getColorScheme(context).surface,
      ),
      borderRadius: BorderRadius.circular(_roundedEdges),
    ),
    height: height,
    width: width,
  );

  @override
  Widget build(BuildContext context) =>
    Column(
      children: [
        posterURL != null ? Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(90),
                spreadRadius: 2,
                blurRadius: 3,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_roundedEdges),
            child: CachedNetworkImage(
              imageUrl: posterURL!,
              height: height,
              width: width,
              fit: BoxFit.cover,
              placeholder: (_, __) => _emptyPoster(context),
              errorWidget: (_, __, ___) => _emptyPoster(context)
            )
          )
        ) : _emptyPoster(context),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Text(
              title ?? '',
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
            fontSize: titleSize * 0.8,
            overflow: TextOverflow.ellipsis,
            color: getColorScheme(context).onPrimary,
            fontWeight: FontWeight.w200
          ),
        ) : Container()
      ]
    );
}
