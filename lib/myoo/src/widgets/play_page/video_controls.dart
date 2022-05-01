import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/src/models/track.dart';
import 'package:myoo/kyoo_api/src/models/video.dart';
import 'package:myoo/myoo/src/actions/streaming_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/widgets/back_button.dart';
import 'package:myoo/myoo/src/widgets/play_page/video_detail.dart';
import 'package:myoo/myoo/src/widgets/play_page/video_parameters.dart';
import 'package:myoo/myoo/src/widgets/play_page/video_slider.dart';

/// Controls for [PlayPage]
/// Callabck don't have to manage state
class VideoControls extends StatelessWidget {

  /// Callback when video slider is moved
  final void Function(Duration) onSlide;

  /// Callback when [StreamingMethod] is selected
  final void Function(StreamingMethod) onMethodSelect;

  final void Function(Track?) onSubtitleTrackSelect;

  /// Callabck when play/pause button is pressed
  final void Function() onPlayToggle;

  const VideoControls({
    Key? key,
    required this.onMethodSelect,
    required this.onPlayToggle,
    required this.onSlide,
    required this.onSubtitleTrackSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GoBackButton(),
          Expanded(child: Container()),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  VideoSlider(
                    position: store.state.streamingParams!.currentPosition,
                    duration: store.state.streamingParams!.totalDuration ?? Duration.zero,
                    onSlide: (newPosition) {
                      store.dispatch(SetCurrentPositionAction(newPosition));
                      onSlide.call(newPosition);
                    }
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    color: getColorScheme(context).background.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 10,
                            child: VideoDetail(
                              video: store.state.currentVideo!,
                              position: store.state.streamingParams!.currentPosition,
                              duration: store.state.streamingParams!.totalDuration ?? Duration.zero,
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: IconButton(
                              icon: Icon(store.state.streamingParams!.isPlaying ? Icons.pause : Icons.play_arrow),
                              onPressed: () {
                                onPlayToggle();
                                store.dispatch(TogglePlayAction());
                              }
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: IconButton(
                              icon: const Icon(Icons.settings),
                              onPressed: () => showModalBottomSheet(
                                backgroundColor: getColorScheme(context).background,
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height / 2,
                                    child: SafeArea(
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 20),
                                          child: VideoParameters(
                                            onMethodSelect: (newMethod) => onMethodSelect(newMethod),
                                            onSubtitleTrackSelect: (track) => onSubtitleTrackSelect(track),
                                          ),
                                        ),
                                      )
                                    ),
                                  );
                                }
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
