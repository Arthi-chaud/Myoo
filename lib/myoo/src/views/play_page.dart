import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
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
  VlcPlayerController? videoController;
  Timer? positionTimer;
  late Slug videoSlug;


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
        store.dispatch(LoadVideoAction(videoSlug));
        store.dispatch(InitStreamingParametersAction());
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
        videoController?.pause();
        videoController?.dispose();
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
            body: Stack(
              alignment: Alignment.center,
              children: store.state.isLoading || store.state.currentVideo == null
                ? [
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
                ]
              : [
                  VlcPlayer(
                    aspectRatio: 16 / 9,
                    controller: videoController!
                  ),
                  HideOnTap(
                    child: VideoControls(
                      onMethodSelect: (newMethod) {
                        setState(() {
                          videoController!.pause();
                          store.dispatch(LoadingAction());
                          videoController!.setMediaFromNetwork(
                            store.state.currentClient!.getStreamingLink(videoSlug, newMethod)
                          ).then((value) => store.dispatch(LoadedAction()));
                        });
                      },
                      onSlide: (position) {
                        videoController!.seekTo(position);
                      },
                      onSubtitleTrackSelect: (_) {
                        videoController!.addSubtitleFromNetwork(
                          store.state.currentClient!
                          .getSubtitleTrackDownloadLink(
                            store.state.streamingParams!.currentSubtitlesTrack!.slug,
                            store.state.streamingParams!.currentSubtitlesTrack!.codec
                          ),
                          isSelected: true
                        );
                      },
                      onPlayToggle: () {
                        if (store.state.streamingParams!.isPlaying) {
                          videoController!.pause();
                        } else {
                          videoController!.play();
                        }
                      },
                    ),
                  )
                ],
            )
          ),
        );
      },
    );
  }
}
