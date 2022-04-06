import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/widgets/image.dart';

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
      mainAxisAlignment: MainAxisAlignment.center,
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
            child: MyooImage(
              posterURL!,
              height: height,
              width: width,
              placeholder: (context) => _emptyPoster(context),
            )
          )
        ) : _emptyPoster(context),
        if (title != null)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Text(
            title!,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: titleSize,
              color: getColorScheme(context).onPrimary
            ),
          ),
        ),
        if (subtitle != null)
        Text(
          subtitle!,
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: titleSize * 0.8,
            color: getColorScheme(context).onPrimary,
            fontWeight: FontWeight.w200
          ),
        ),
      ]
    );
}
