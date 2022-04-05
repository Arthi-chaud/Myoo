import 'package:flutter/material.dart';
import 'package:myoo/kyoo_api/src/models/external_id.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/widgets/icon_button.dart';
import 'package:share_plus/share_plus.dart';

/// A Clickable Button to share a [Movie]/[TVSeries]'s [ExternalID]s and their download link
class ShareButton extends StatelessWidget {
  /// The URL to download a [Movie]
  final String? downloadLink;

  /// [ExternalID]s of a [Movie]/[TVSeries]
  final List<ExternalID> externalIDs;
  const ShareButton({Key? key, required this.downloadLink, required this.externalIDs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: const DetailPageIconButton(
        label: 'Share',
        icon: Icons.share,
        onTap: null
      ),
      color: getColorScheme(context).background,
      itemBuilder: (context) => [
        if (downloadLink != null)
        PopupMenuItem(
          child: const Text('Download'),
          value: downloadLink!
        ),
        for (var externalID in externalIDs)
        PopupMenuItem(
          child: Text(externalID.provider.name),
          value: externalID.externalURL
        )
      ],
    );
  }
}
