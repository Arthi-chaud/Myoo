import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/theme_data.dart';

/// Common scaffold wrapperfor every view
/// Basically wrapps a given a scaffold in a [SafeArea], with a background color
class SafeScaffold extends StatelessWidget {

  /// The scaffold to wrap
  final Widget scaffold;

  final bool bottom;
  final bool left;
  final bool right;
  final bool top;

  final Color? backgroundColor;

  const SafeScaffold({Key? key, required this.scaffold, this.bottom = false, this.left = true, this.right = true, this.top = true, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? getColorScheme(context).background,
      child: SafeArea(
        bottom: bottom,
        top: top,
        left: left,
        right: right,
        child: scaffold
      ),
    );
  }
}
