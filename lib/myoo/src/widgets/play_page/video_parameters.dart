import 'dart:io';

import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/track.dart';
import 'package:myoo/myoo/src/actions/streaming_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/models/streaming_parameters.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:recase/recase.dart';

/// Widget to choose the video's streaming method & the subtitles
/// It uses the [StreamingParameters] of the [AppState] to get choices
/// onSelect callbacks don't have to change state
class VideoParameters extends StatefulWidget {
  /// Callback on [StreamingMethod] change
  final void Function(StreamingMethod) onMethodSelect;

  /// Callback on [StreamingMethod] change
  final void Function(Track?) onSubtitleTrackSelect;

  const VideoParameters({Key? key, required this.onMethodSelect, required this.onSubtitleTrackSelect}) : super(key: key);

  @override
  State<VideoParameters> createState() => _VideoParametersState();
}

class _VideoParametersState extends State<VideoParameters> {

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
    return StoreBuilder<AppState>(
      builder: (context, store) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Streaming Method"),
            ChipsChoice<StreamingMethod>.single(
              wrapped: true,
              choiceStyle: choiceStyle,
              choiceActiveStyle: selectedChoiseStyle,
              value: store.state.streamingParams!.method,
              onChanged: (newMethod) {
                widget.onMethodSelect(newMethod);
                store.dispatch(SetStreamingMethodAction(newMethod));
              },
              choiceItems: [
                for (var method in StreamingMethod.values)
                  C2Choice<StreamingMethod>(
                    value: method,
                    label: ReCase(method.name).titleCase,
                  ),
              ],
            ),
            if (store.state.currentVideo!.subtitleTracks.isEmpty)
              const Text("No subtitles available...")
            else
            ...[
              const Text("Subtitle"),
              ChipsChoice<Track?>.single(
                choiceStyle: choiceStyle,
                value: store.state.streamingParams?.currentSubtitlesTrack,
                choiceActiveStyle: selectedChoiseStyle,
                onChanged: (newTrack) {
                  store.dispatch(SetSubtitlesTrackAction(newTrack));
                  widget.onSubtitleTrackSelect(newTrack);
                },
                choiceItems: [
                  for (Track subtitleTrack in store.state.currentVideo!.subtitleTracks)
                    C2Choice<Track>(
                      value: subtitleTrack,
                      label: "${subtitleTrack.displayName} (${subtitleTrack.isForced ? 'Forced ' : '' }${ReCase(subtitleTrack.codec).titleCase})",
                    ),
                ],
              ),
            ]
          ],
        );
      }
    );
  }
}
