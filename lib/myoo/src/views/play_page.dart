import 'package:chewie/chewie.dart';
import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/myoo/src/actions/loading_actions.dart';
import 'package:myoo/myoo/src/actions/navigation_actions.dart';
import 'package:myoo/myoo/src/actions/video_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/widgets/hide_on_tap.dart';
import 'package:myoo/myoo/src/widgets/loading_widget.dart';
import 'package:myoo/myoo/src/widgets/poster.dart';
import 'package:myoo/myoo/src/widgets/safe_scaffold.dart';
import 'package:redux/redux.dart';
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

  String getVideoTitle(Video video, TVSeries? tvSeries, Season? season) {
    if (video is Movie) {
      return video.name;
    } else if (video is Episode) {
      return "${tvSeries!.name}: S${season!.index} - E${video.index}";
    }
    throw Exception("Unknown video type");
  }

  String? getVideoPoster(Video video, TVSeries? tvSeries, Season? season) {
    if (video is Movie) {
      return video.poster;
    } else if (video is Episode) {
      return season!.poster ?? tvSeries!.poster;
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      onInit: ((store) async {
        Video currentVideo = store.state.currentVideo!;
        TVSeries? tvSeries = store.state.currentTVSeries;
        Season? season = store.state.currentSeason;
        KyooClient currentClient = store.state.currentClient!;

        store.dispatch(LoadingAction());
        videoController = VideoPlayerController.network(
          currentClient.getStreamingLink(currentVideo.slug, StreamingMethod.transmux)
        );
        await videoController!.initialize();
        chewieController = ChewieController(
          videoPlayerController: videoController!,
          allowFullScreen: false,
          autoPlay: true,
          customControls: HideOnTap(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackButton(),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 100,
                      color: getColorScheme(context).background.withOpacity(0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Poster(posterURL: getVideoPoster(currentVideo, tvSeries, season), height: 80),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getVideoTitle(currentVideo, tvSeries, season),
                                  ),
                                  Text(
                                    "${formatDuration(videoController!.value.position)} - ${formatDuration(videoController!.value.duration)}",
                                    style: const TextStyle(fontSize: 10),
                                  )
                                ],
                              )
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.play_arrow),
                            onPressed: () => chewieController!.togglePause(),
                          ),
                        ],
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),
          showControlsOnInitialize: false,
          allowPlaybackSpeedChanging: false,
        );
        store.dispatch(LoadedAction());
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
            appBar: store.state.isLoading ? AppBar(
              leading: const BackButton(),
              backgroundColor: Colors.transparent,
            ) : null,
            backgroundColor: Colors.black,
            body: store.state.isLoading ?
              const Center(
                child: LoadingWidget(),
              ) : Chewie(controller: chewieController!),
          ),
        );
      },
    );
  }
}
