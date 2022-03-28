import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/theme_data.dart';

/// Widget to display an overview, and make it expandable
class ExpandableOverview extends StatelessWidget {
  /// Overview to display and make expnadable
  final String overview;
  /// Maximum number of lines to display
  final int maxLines;

  const ExpandableOverview(this.overview, {Key? key, required this.maxLines}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ExpandableText(
      overview,
      expandText: 'Show more',
      maxLines: maxLines,
      linkColor: getColorScheme(context).onBackground,
      linkStyle: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
