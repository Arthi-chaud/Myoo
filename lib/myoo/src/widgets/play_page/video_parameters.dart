import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/track.dart';
import 'package:myoo/myoo/src/actions/streaming_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/models/streaming_parameters.dart';
import 'package:myoo/myoo/src/theme_data.dart';

/// Widget to choose the video's streaming method & the subtitles
/// It uses the [StreamingParameters] of the [AppState] to get choices
/// onSelect callbacks don't have to change state
class VideoParameters extends StatefulWidget {
  /// Callback on [StreamingMethod] change
  final void Function(StreamingMethod) onMethodSelect;

  /// Callback on subtitles [Track] change
  final void Function(Track?) onSubtitleTrackSelect;

  /// Callback on audio [Track] change
  final void Function(Track) onAudioTrackSelect;

  const VideoParameters({Key? key, required this.onMethodSelect, required this.onSubtitleTrackSelect, required this.onAudioTrackSelect}) : super(key: key);

  @override
  State<VideoParameters> createState() => _VideoParametersState();
}

class _VideoParametersState extends State<VideoParameters> {

  Widget paddedTitle(String title) => Padding(
    padding: const EdgeInsets.only(left: 20),
    child: Text(title),
  );

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
            /*paddedTitle("Streaming Method"),
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
            ),*/
            if (store.state.currentVideo!.subtitleTracks.isEmpty)
              paddedTitle("No subtitles available...")
            else
            ...[
              paddedTitle("Subtitles"),
              ChipsChoice<Track?>.single(
                wrapped: true,
                choiceStyle: choiceStyle,
                value: store.state.streamingParams?.currentSubtitlesTrack,
                choiceActiveStyle: selectedChoiseStyle,
                onChanged: (newTrack) {
                  store.dispatch(SetSubtitlesTrackAction(newTrack));
                  widget.onSubtitleTrackSelect(newTrack);
                },
                choiceItems: [
                  C2Choice<Track?>(
                    value: null,
                    label: "None",
                    selected: store.state.streamingParams?.currentSubtitlesTrack == null
                  ),
                  for (Track subtitleTrack in store.state.currentVideo!.subtitleTracks)
                    C2Choice<Track>(
                      value: subtitleTrack,
                      label: subtitleTrack.displayName,
                    ),
                ],
              ),
            ],
            ...[
              paddedTitle("Audio"),
              ChipsChoice<Track?>.single(
                wrapped: true,
                choiceStyle: choiceStyle,
                value: store.state.streamingParams!.currentAudioTrack,
                choiceActiveStyle: selectedChoiseStyle,
                onChanged: (newTrack) {
                  store.dispatch(SetAudioTrackAction(newTrack!));
                  widget.onAudioTrackSelect(newTrack);
                },
                choiceItems: [
                  for (Track subtitleTrack in store.state.currentVideo!.audioTracks)
                    C2Choice<Track>(
                      value: subtitleTrack,
                      label: subtitleTrack.displayName,
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
