import 'dart:io';

import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/myoo/src/models/streaming_parameters.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:recase/recase.dart';

/// Widget to choose the video's streaming method & the subtitles
class VideoParameters extends StatefulWidget {
  /// The current streaming parameters
  final StreamingParameters streamingParameters;

  /// Callback on [StreamingMethod] change
  final void Function(StreamingMethod) onMethodSelect;

  /// Callback on [StreamingMethod] change
  final void Function() onSubtitleTrackSelect;

  const VideoParameters({Key? key, required this.streamingParameters, required this.onMethodSelect, required this.onSubtitleTrackSelect}) : super(key: key);

  @override
  State<VideoParameters> createState() => _VideoParametersState();
}

class _VideoParametersState extends State<VideoParameters> {
  late StreamingMethod currentMethod;

  @override
  void initState() {
    super.initState();
    currentMethod = widget.streamingParameters.method;
  }

  @override
  Widget build(BuildContext context) {
    C2ChoiceStyle choiceStyle = C2ChoiceStyle(
      color: getColorScheme(context).secondary,
      borderColor: getColorScheme(context).secondary,
      backgroundColor: getColorScheme(context).background,
    );
    C2ChoiceStyle selectedChoiseStyle = choiceStyle.copyWith(
      backgroundColor: getColorScheme(context).secondary,
      color: getColorScheme(context).onSecondary,
    );
    return Wrap(
      direction: Axis.vertical,
      children: [
        const Text("Streaming Method"),
        ChipsChoice<StreamingMethod>.single(
          choiceStyle: choiceStyle,
          choiceActiveStyle: selectedChoiseStyle,
          value: currentMethod,
          onChanged: (newMethod) {
            widget.onMethodSelect(newMethod);
            setState(() {
              currentMethod = newMethod;
            });
          },
          choiceItems: [
            for (var method in StreamingMethod.values)
              C2Choice<StreamingMethod>(
                value: method,
                disabled: Platform.isIOS && method == StreamingMethod.direct,
                label: ReCase(method.name).titleCase,
              ),
          ],
        ),
        const Text("Subtitle"),
      ],
    );
  }
}
