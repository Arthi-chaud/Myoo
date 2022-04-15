import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';
import 'package:myoo/myoo/myoo_api.dart';
import 'package:myoo/myoo/src/widgets/play_page/error_widget.dart';
import 'package:redux/redux.dart';
import 'package:video_player/video_player.dart';

class PlayPage extends StatefulWidget {

  /// Error message if the video takes too long to load
  static String loadTimeoutMessage = 'The video is taking too long to load. Please try again later. Its format might be incompatible with the player';
  /// Duration in seconds to wait before showing the error widget
  static int loadTimeout = 10;

  const PlayPage({Key? key}) : super(key: key);

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  VideoPlayerController? videoController;
  ChewieController? chewieController;
  Timer? positionTimer;
  late Slug videoSlug;
  ///TODO Make the page not refresh every second
  ChewieController getChewieController(VideoPlayerController videoController, {required bool autoplay, Widget? controls, Duration? position}) {
    return ChewieController(
      videoPlayerController: videoController,
      allowFullScreen: false,
      autoPlay: autoplay,
      startAt: position,
      customControls: Stack(
        children: [
          ClosedCaption(
            text: videoController.value.caption.text,
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          HideOnTap(
            child: controls ?? Container()
          )
        ]
      ),
      showControlsOnInitialize: false,
      allowPlaybackSpeedChanging: false,
    );
  }

  void buildVideoController(String videoURL, void Function() onLoaded, {String? subtitleURL, Duration? startPosition}) {
    videoController = VideoPlayerController.network(
      videoURL,
      closedCaptionFile: subtitleURL != null ? SubtitleTrack.fromURL(subtitleURL) : null,
    );
    videoController!.initialize().then((value) {
      chewieController = getChewieController(
        videoController!,
        autoplay: true,
        position: startPosition
      );
      onLoaded();
    });
  }

  void rebuildVideoController(Store<AppState> store) {
    setState(() {
      videoController?.dispose();
      chewieController?.dispose();
      videoController = null;
      chewieController = null;
    });
    buildVideoController(
      store.state.currentClient!.getStreamingLink(videoSlug, store.state.streamingParams!.method),
      () => store.dispatch(LoadedAction()),
      startPosition: store.state.streamingParams!.currentPosition,
      subtitleURL: store.state.streamingParams?.currentSubtitlesTrack != null
        ? store.state.currentClient!
          .getSubtitleTrackDownloadLink(
            store.state.streamingParams!.currentSubtitlesTrack!.slug,
            store.state.streamingParams!.currentSubtitlesTrack!.codec
          )
        : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      onInit: ((store) {
        videoSlug = ModalRoute.of(context)!.settings.name!.replaceAll('/play/', '');
        store.dispatch(LoadVideoAction(videoSlug));
        store.dispatch(InitStreamingParametersAction());
        Future.delayed(const Duration(seconds: 10), () {
          if (chewieController == null) {
            showPlayErrorWidget(context, PlayPage.loadTimeoutMessage);
          }
        });
        buildVideoController(
          store.state.currentClient!.getStreamingLink(videoSlug, store.state.streamingParams!.method),
          () {
            positionTimer = Timer.periodic(
              const Duration(seconds: 1),
              (_) {
                store.dispatch(SetCurrentPositionAction(videoController!.value.position));
                store.dispatch(SetTotalDurationAction(videoController!.value.duration));
              }
            );
            store.dispatch(LoadedAction());
          }
        );
      }),
      onDispose: ((store) {
        positionTimer?.cancel();
        chewieController?.pause();
        videoController?.dispose();
        chewieController?.dispose();
        store.dispatch(UnloadVideoAction());
        store.dispatch(UnsetStreamingParametersAction());
      }),
      //ignoreChange: (state) => state.streamingParams!.totalDuration != null,
      builder: (context, store) {
        bool controllerIsLoading = chewieController == null;
        return SafeScaffold(
          bottom: true,
          backgroundColor: Colors.black,
          scaffold: Scaffold(
            appBar: store.state.isLoading || controllerIsLoading
            ? AppBar(
              leading: const GoBackButton(),
              backgroundColor: Colors.transparent,
            ) : null,
            backgroundColor: Colors.black,
            body: store.state.isLoading || controllerIsLoading || store.state.currentVideo == null
            ? Stack(
              alignment: Alignment.center,
              children: [
                DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                    color: getColorScheme(context).background.withAlpha(200)
                  ),
                  child: Thumbnail(
                    thumbnailURL: store.state.currentVideo?.thumbnail,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                const LoadingWidget(),
              ],
            )
            : Chewie(
              controller: getChewieController(
                videoController!,
                autoplay: false,
                controls: VideoControls(
                  onSubtitleTrackSelect: (_) => rebuildVideoController(store),
                  onMethodSelect: (newMethod) => rebuildVideoController(store),
                  onPlayToggle: () => chewieController!.togglePause(),
                  onSlide: (position) => chewieController!.seekTo(position),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
