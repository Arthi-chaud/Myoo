import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/widgets/detail_page/icon_button.dart';
import 'package:url_launcher/url_launcher.dart';

/// Icon button to play trailer using its URL an item
class TrailerButton extends StatelessWidget {
  /// The URL of the item to download
  final String trailerUrl;

  const TrailerButton(this.trailerUrl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    DetailPageIconButton(
      onTap: () => launch(Uri.parse(trailerUrl).toString()),
      icon: const Icon(Icons.local_movies),
      label: "Trailer"
    );
}
