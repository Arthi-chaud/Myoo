import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';
import 'package:myoo/kyoo_api/src/models/track.dart';
import 'package:myoo/myoo/myoo_api.dart';
import 'package:myoo/myoo/src/widgets/play_page/error_widget.dart';
import 'package:myoo/myoo/src/widgets/play_page/video_loading.dart';

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
  VlcPlayerController? videoController;
  Timer? positionTimer;
  late Slug videoSlug;

  void videoControllerSetSubtitleTrack(Track? newTrack) {
    if (newTrack == null) {
      videoController!.setSpuTrack(-1);
      return;
    }
    videoController!.getSpuTracks().then(
      (tracks) {
        tracks.removeWhere((key, value) => !value.contains(newTrack.displayName));
        tracks.removeWhere((key, value) => newTrack.isForced ^ value.contains("Forced"));
        if (tracks.isNotEmpty) {
          List<int> keys = tracks.keys.toList()..sort();
          videoController!.setSpuTrack(keys[newTrack.index - 1]);
        }
      }
    );
  }


  void buildVideoController(String videoURL, void Function() onLoaded) {
    videoController = VlcPlayerController.network(
      videoURL,
    )..addOnInitListener(() {
      onLoaded();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      onInit: ((store) {
        videoSlug = ModalRoute.of(context)!.settings.name!.replaceAll('/play/', '');
        store.dispatch(InitStreamingParametersAction());
        store.dispatch(LoadVideoAction(videoSlug));
        Future.delayed(const Duration(seconds: 10), () {
          if (store.state.isLoading) {
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
        videoController?.dispose().onError((error, stackTrace) {});
        store.dispatch(UnloadVideoAction());
        store.dispatch(UnsetStreamingParametersAction());
      }),
      builder: (context, store) {
        return SafeScaffold(
          bottom: true,
          backgroundColor: Colors.black,
          scaffold: Scaffold(
            appBar: store.state.isLoading
            ? AppBar(
              leading: const GoBackButton(),
              backgroundColor: Colors.transparent,
            ) : null,
            backgroundColor: Colors.black,
            body: store.state.isLoading || store.state.currentVideo == null
              ? VideoLoadingWidget(
                thumbnailURL: store.state.currentVideo?.thumbnail,
              )
              : Stack(
                alignment: Alignment.center,
                children: [
                  VlcPlayer(
                    aspectRatio: 16 / 9,
                    controller: videoController!,
                  ),
                  (videoController?.value.position.inMicroseconds ?? 0) > 0
                  ? HideOnTap(
                    child: VideoControls(
                      onMethodSelect: (newMethod) {
                        setState(() {
                          store.dispatch(LoadingAction());
                          videoController!.pause();
                          videoController!.setMediaFromNetwork(
                            store.state.currentClient!.getStreamingLink(videoSlug, newMethod)
                          ).then(
                            (value) {
                              store.dispatch(LoadedAction());
                            }
                          );
                        });
                      },
                      onSlide: (position) {
                        videoController!.seekTo(position);
                      },
                      onSubtitleTrackSelect: (newTrack) => videoControllerSetSubtitleTrack(newTrack),
                      onPlayToggle: () {
                        if (store.state.streamingParams!.isPlaying) {
                          videoController!.pause();
                        } else {
                          videoController!.play();
                        }
                      },
                    ),
                  )
                  : VideoLoadingWidget(
                    thumbnailURL: store.state.currentVideo?.thumbnail,
                  )
                ],
            )
          ),
        );
      },
    );
  }
}
