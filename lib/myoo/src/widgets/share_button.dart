import 'package:flutter/material.dart';
import 'package:myoo/kyoo_api/src/models/external_id.dart';
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
    return DetailPageIconButton(
      label: 'Share',
      icon: const Icon(Icons.share),
      onTap: () => Share.share(downloadLink!),
    );
  }
}
