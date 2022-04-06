import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';
import 'package:myoo/myoo/src/actions/loading_actions.dart';
import 'package:myoo/myoo/src/actions/streaming_actions.dart';
import 'package:myoo/myoo/src/actions/video_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/widgets/back_button.dart';
import 'package:myoo/myoo/src/widgets/hide_on_tap.dart';
import 'package:myoo/myoo/src/widgets/loading_widget.dart';
import 'package:myoo/myoo/src/widgets/play_page/video_detail.dart';
import 'package:myoo/myoo/src/widgets/play_page/video_parameters.dart';
import 'package:myoo/myoo/src/widgets/play_page/video_slider.dart';
import 'package:myoo/myoo/src/widgets/safe_scaffold.dart';
import 'package:redux/redux.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:video_player/video_player.dart';

class PlayPage extends StatefulWidget {

  const PlayPage({Key? key}) : super(key: key);

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  VideoPlayerController? videoController;
  ChewieController? chewieController;

  ChewieController getChewieController(VideoPlayerController videoController, {required bool autoplay, Widget? controls}) {
    return ChewieController(
      videoPlayerController: videoController,
      allowFullScreen: false,
      autoPlay: autoplay,
      customControls: controls ?? Container(),
      showControlsOnInitialize: false,
      allowPlaybackSpeedChanging: false,
    );
  }

  Widget getControls(Store<AppState> store, {Duration position = Duration.zero, Duration? duration}) {
    AppState state = store.state;
    if (position == Duration.zero) {
      position = const Duration(milliseconds: 1);
    }
    if (duration == Duration.zero || duration == null || duration.inSeconds < position.inSeconds) {
      duration = const Duration(seconds: 42);
    }
    return HideOnTap(
      child: Column(
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
                    position: position,
                    duration: duration,
                    onSlide: (newPosition) => chewieController!.seekTo(newPosition)
                  ),
                  Container(
                    height: 100,
                    color: getColorScheme(context).background.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          VideoDetail(
                            video: store.state.currentVideo!,
                            position: position,
                            duration: duration,
                          ),
                          Expanded(
                            flex: 8,
                            child: IconButton(
                              icon: Icon(state.streamingParams!.isPlaying ? Icons.pause : Icons.play_arrow),
                              onPressed: () {
                                store.dispatch(TogglePlayAction());
                                chewieController!.togglePause();
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
                                  return SafeArea(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: VideoParameters(
                                        streamingParameters: state.streamingParams!,
                                        onMethodSelect: (method) => store.dispatch(SetStreamingMethodAction(method)),
                                        onSubtitleTrackSelect: () {}, ///TODO
                                      ),
                                    )
                                  );
                                }
                              ),
                            ),
                          ),
                          ///TODO Manage subtitles
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


  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      onInit: ((store) {
        Slug slug = ModalRoute.of(context)!.settings.name!.replaceAll('/play/', '');
        store.dispatch(LoadVideoAction(slug));
        store.dispatch(InitStreamingParametersAction());
        videoController = VideoPlayerController.network(
          store.state.currentClient!.getStreamingLink(slug, store.state.streamingParams!.method),
        );
        videoController!.initialize().then(
          (_) {
            chewieController = getChewieController(videoController!, autoplay: true);
            store.dispatch(LoadedAction());
          }
        );
      }),
      onDispose: ((store) {
        chewieController?.pause();
        videoController?.dispose();
        chewieController?.dispose();
        store.dispatch(UnloadVideoAction());
        store.dispatch(UnsetStreamingParametersAction());
      }),
      builder: (context, store) {
        bool isLoading = store.state.isLoading || store.state.currentVideo == null || chewieController == null;
        return SafeScaffold(
          bottom: true,
          backgroundColor: Colors.black,
          scaffold: Scaffold(
            appBar: isLoading
            ? AppBar(
              leading: const GoBackButton(),
              backgroundColor: Colors.transparent,
            ) : null,
            backgroundColor: Colors.black,
            body: isLoading
              ? const Center(
                child: LoadingWidget(),
              )
              : TimerBuilder.periodic(
                const Duration(seconds: 1),
                builder: (context) {
                  return Chewie(
                    controller: getChewieController(
                      videoController!,
                      autoplay: false,
                      controls: getControls(
                        store,
                        position: videoController!.value.position,
                        duration: videoController!.value.duration
                      ),
                    ),
                  );
                }
              ),
          ),
        );
      },
    );
  }
}
