import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';
import 'package:myoo/myoo/src/actions/loading_actions.dart';
import 'package:myoo/myoo/src/actions/streaming_actions.dart';
import 'package:myoo/myoo/src/actions/video_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/widgets/back_button.dart';
import 'package:myoo/myoo/src/widgets/hide_on_tap.dart';
import 'package:myoo/myoo/src/widgets/loading_widget.dart';
import 'package:myoo/myoo/src/widgets/play_page/video_controls.dart';
import 'package:myoo/myoo/src/widgets/safe_scaffold.dart';
import 'package:video_player/video_player.dart';

class PlayPage extends StatefulWidget {

  const PlayPage({Key? key}) : super(key: key);

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  VideoPlayerController? videoController;
  ChewieController? chewieController;
  Timer? positionTimer;
  late Slug videoSlug;

  ChewieController getChewieController(VideoPlayerController videoController, {required bool autoplay, Widget? controls}) {
    return ChewieController(
      videoPlayerController: videoController,
      allowFullScreen: false,
      autoPlay: autoplay,
      customControls: controls != null ? HideOnTap(
        child: controls
      ) : null,
      showControlsOnInitialize: false,
      allowPlaybackSpeedChanging: false,
    );
  }

  void buildVideoController(String videoURL, void Function() onLoaded) {
    videoController = VideoPlayerController.network(videoURL);
    videoController!.initialize().then((value) => onLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      onInit: ((store) {
        videoSlug = ModalRoute.of(context)!.settings.name!.replaceAll('/play/', '');
        store.dispatch(LoadVideoAction(videoSlug));
        store.dispatch(InitStreamingParametersAction());
        buildVideoController(
          store.state.currentClient!.getStreamingLink(videoSlug, store.state.streamingParams!.method),
          () {
            chewieController = getChewieController(videoController!, autoplay: true);
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
            body: store.state.isLoading || controllerIsLoading
            ? const Center(
              child: LoadingWidget(),
            )
            : Chewie(
              controller: getChewieController(
                videoController!,
                autoplay: false,
                controls: VideoControls(
                  onMethodSelect: (newMethod) {
                    store.dispatch(SetStreamingMethodAction(newMethod));
                    setState(() {
                      videoController?.dispose();
                      chewieController?.dispose();
                      videoController = null;
                      chewieController = null;
                    });
                    buildVideoController(
                      store.state.currentClient!.getStreamingLink(videoSlug, newMethod),
                      () {
                        chewieController = getChewieController(videoController!, autoplay: true);
                        store.dispatch(LoadedAction());
                      }
                    );
                  },
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
