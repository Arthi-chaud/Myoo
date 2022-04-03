import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';
import 'package:myoo/kyoo_api/src/models/watch_item.dart';
import 'package:myoo/myoo/src/actions/loading_actions.dart';
import 'package:myoo/myoo/src/actions/video_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/widgets/hide_on_tap.dart';
import 'package:myoo/myoo/src/widgets/loading_widget.dart';
import 'package:myoo/myoo/src/widgets/poster.dart';
import 'package:myoo/myoo/src/widgets/safe_scaffold.dart';
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

  Widget getControls(String? poster, String title, String? secondTitle, bool isPlaying, {Duration position = Duration.zero, Duration? duration}) {
    if (duration == Duration.zero || duration == null) {
      duration = const Duration(seconds: 42);
    }
    return HideOnTap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BackButton(),
          Expanded(child: Container()),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Slider.adaptive(
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
                              Poster(posterURL: poster, height: 80),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2
                                    ),
                                    if (secondTitle != null)
                                    Text(
                                      secondTitle,
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
                              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                              onPressed: () => chewieController!.togglePause(),
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
        print(slug);
        store.dispatch(LoadVideoAction(slug));
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
      }),
      builder: (context, store) {
        return SafeScaffold(
          bottom: true,
          backgroundColor: Colors.black,
          scaffold: Scaffold(
            appBar: store.state.isLoading || store.state.currentVideo == null ? AppBar(
              leading: const BackButton(),
              backgroundColor: Colors.transparent,
            ) : null,
            backgroundColor: Colors.black,
            body: store.state.isLoading
              ? const Center(
                child: LoadingWidget(),
              )
              : TimerBuilder.periodic(
                const Duration(seconds: 1),
                builder: (context) {
                  WatchItem currentVideo = store.state.currentVideo!;
                  return Chewie(
                    controller: getChewieController(
                      videoController!,
                      autoplay: false,
                      controls: getControls(
                        currentVideo.poster,
                        getVideoTitle(currentVideo),
                        currentVideo.name,
                        videoController!.value.isPlaying,
                        position: videoController!.value.position, duration: videoController!.value.duration
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
