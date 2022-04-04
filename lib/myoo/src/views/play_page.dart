import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';
import 'package:myoo/kyoo_api/src/models/watch_item.dart';
import 'package:myoo/myoo/src/actions/loading_actions.dart';
import 'package:myoo/myoo/src/actions/streaming_actions.dart';
import 'package:myoo/myoo/src/actions/video_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/widgets/back_button.dart';
import 'package:myoo/myoo/src/widgets/hide_on_tap.dart';
import 'package:myoo/myoo/src/widgets/loading_widget.dart';
import 'package:myoo/myoo/src/widgets/poster.dart';
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

  String formatDuration(Duration duration) {
    String timeString = duration.toString().split('.').first;
    if (timeString.startsWith('0:')) {
      timeString = timeString.substring(2);
    }
    return timeString;
  }

  String getVideoTitle(WatchItem video) {
    if (video.parentSeasonIndex != null && video.index != null) {
      return "${video.parentName}: S${video.parentSeasonIndex} - E${video.index}";
    }
    return video.parentName;
  }

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
                  Slider(
                    activeColor: getColorScheme(context).secondary,
                    value: position.inSeconds.toDouble(),
                    max: duration.inSeconds.toDouble(),
                    onChanged: (newPosition) {
                      chewieController?.seekTo(Duration(seconds: newPosition.toInt()));
                    },
                  ),
                  Container(
                    height: 100,
                    color: getColorScheme(context).background.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Poster(posterURL: state.currentVideo!.poster, height: 80),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getVideoTitle(state.currentVideo!),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2
                                    ),
                                    if (state.currentVideo!.name != state.currentVideo!.parentName)
                                    Text(
                                      state.currentVideo!.name,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      "${formatDuration(position)} - ${formatDuration(duration)}",
                                      style: const TextStyle(fontSize: 10),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: IconButton(
                              icon: Icon(state.streamingParams!.isPlaying ? Icons.pause : Icons.play_arrow),
                              onPressed: () {
                                store.dispatch(TogglePlayAction());
                                chewieController!.togglePause();
                              }
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
          store.state.currentClient!.getStreamingLink(slug, StreamingMethod.transmux)
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
