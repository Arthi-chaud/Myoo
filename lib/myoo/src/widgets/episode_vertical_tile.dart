import 'package:flutter/material.dart';
import 'package:myoo/myoo/myoo_api.dart';

/// A preview of an [Episode], but the direction is vertical
class EpisodeVerticalTile extends StatelessWidget {
  /// URL of the thumbnail of the episode
  final String? thumbnailURL;
  /// Title of the Episode
  final String title;
  /// Overview of the episode.
  /// Will be croppped if too long
  final String overview;
  const EpisodeVerticalTile({
    Key? key,
    required this.thumbnailURL,
    required this.title,
    required this.overview
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Thumbnail(
          thumbnailURL: thumbnailURL
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          overview,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 10
          ),
        )
      ],
    );
  }
  
}