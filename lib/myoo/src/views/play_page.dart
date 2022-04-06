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
  Timer? positionTimer;

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

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      converter: (store) => store.state.isLoading,
      onInit: ((store) {
        Slug slug = ModalRoute.of(context)!.settings.name!.replaceAll('/play/', '');
        store.dispatch(LoadVideoAction(slug));
        store.dispatch(InitStreamingParametersAction());
        videoController = VideoPlayerController.network(
          store.state.currentClient!.getStreamingLink(slug, store.state.streamingParams!.method), ///TODO rebuild on method change
        );
        videoController!.initialize().then(
          (_) {
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
      ignoreChange: (state) => state.streamingParams!.totalDuration != null,
      builder: (context, isLoading) {
        bool controllerIsLoading = chewieController == null;
        return SafeScaffold(
          bottom: true,
          backgroundColor: Colors.black,
          scaffold: Scaffold(
            appBar: isLoading || controllerIsLoading
            ? AppBar(
              leading: const GoBackButton(),
              backgroundColor: Colors.transparent,
            ) : null,
            backgroundColor: Colors.black,
            body: isLoading || controllerIsLoading
            ? const Center(
              child: LoadingWidget(),
            )
            : Chewie(
              controller: getChewieController(
                videoController!,
                autoplay: false,
                controls: VideoControls(
                  onMethodSelect: (_) {},
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
