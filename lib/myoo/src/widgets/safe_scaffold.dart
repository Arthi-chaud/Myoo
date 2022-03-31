import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/theme_data.dart';

/// Common scaffold wrapperfor every view
/// Basically wrapps a given a scaffold in a [SafeArea], with a background color
class SafeScaffold extends StatelessWidget {

  /// The scaffold to wrap
  final Widget scaffold;

  final bool bottom;

  const SafeScaffold({Key? key, required this.scaffold, this.bottom = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getColorScheme(context).background,
      child: SafeArea(
        bottom: bottom,
        child: scaffold
      ),
    );
  }
}
