import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/myoo/src/widgets/detail_page/expandable_overview.dart';
import 'package:myoo/myoo/src/widgets/thumbnail.dart';

class EpisodeTile extends StatelessWidget {
  /// [Episode] whose thumbnail & overview will be listed
  final Episode episode;
  const EpisodeTile({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Thumbnail(
              thumbnailURL: episode.thumbnail,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(episode.name),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: ExpandableOverview(episode.overview, maxLines: 3),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
