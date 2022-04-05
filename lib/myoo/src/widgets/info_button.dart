import 'package:flutter/material.dart';
import 'package:myoo/kyoo_api/src/models/external_id.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/widgets/icon_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// A Clickable Button to access a [Movie]/[TVSeries]'s [ExternalID]s
class InfoButton extends StatelessWidget {

  /// [ExternalID]s of a [Movie]/[TVSeries]
  final List<ExternalID> externalIDs;
  const InfoButton({Key? key, required this.externalIDs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      child: const DetailPageIconButton(
        label: 'Info',
        icon: Icons.info,
        onTap: null
      ),
      color: getColorScheme(context).background,
      onSelected: (value) => launch(value),
      itemBuilder: (context) => [
        for (var externalID in externalIDs)
        PopupMenuItem(
          child: Text(externalID.provider.name),
          value: externalID.externalURL
        )
      ],
    );
  }
}
