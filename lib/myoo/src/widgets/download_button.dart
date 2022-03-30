import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/widgets/detail_page/icon_button.dart';
import 'package:url_launcher/url_launcher.dart';

/// Icon button to download an item
/// On tap, it opens a browser to download the item
class DownloadButton extends StatelessWidget {
  /// The URL of the item to download
  final String downloadUrl;

  /// Callback on button tap
  final void Function()? onTap;

  const DownloadButton(this.downloadUrl, {Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    DetailPageIconButton(
      onTap: () {
        onTap?.call();
        launch(
          Uri.parse(downloadUrl).toString(),
          forceSafariVC: false,
        );
      },
      icon: const Icon(Icons.download),
      label: "Download"
    );
}
