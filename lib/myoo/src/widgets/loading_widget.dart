import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myoo/myoo/src/theme_data.dart';

/// Loading animation for all loading processes in [Myoo]
/// The loader will be centered in the parent widget
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Center(
      child: LoadingAnimationWidget.twoRotatingArc(
        color: getColorScheme(context).secondary,
        size: 40
      )
    );
}
