import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Timer? systemBarTimer;

  /// From a VLC Player's track, build a Kyoo's [Track]
  Track buildFromVLCTrack(int key, String value) {
    return Track(
      displayName: value,
      isDefault: false,
      codec: '',
      id: key,
      slug: value,
      language: value,
      isForced: value.contains("Forced"),
      index: key,
    );
  }

  void buildVideoController(String videoURL, void Function() onLoaded) {
    videoController = VlcPlayerController.network(
      videoURL,
    )..addOnInitListener(() {
      onLoaded();
    });
  }

  /// Build tracks from VLC's API values & run clalbakcs on build (store dispatch)
  void buildTracksFromVLC(Map<int, String> tracks, int currIndex, void Function(List<Track>) onBuild, void Function(Track) onCurrentTrackBuild) {
    List<Track> kyooTracks = [];
    tracks.forEach((key, value) {
      Track newtrack = buildFromVLCTrack(key, value);
      kyooTracks.add(newtrack);
      if (currIndex == key) {
        onCurrentTrackBuild(newtrack);
      }
    });
    kyooTracks.sort((t1, t2) => t1.displayName.compareTo(t2.displayName));
    onBuild(kyooTracks);
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      onInit: ((store) {
        videoSlug = ModalRoute.of(context)!.settings.name!.replaceAll('/play/', '');
        store.dispatch(InitStreamingParametersAction());
        store.dispatch(LoadVideoAction(videoSlug));
        systemBarTimer = Timer.periodic(
          const Duration(seconds: 5),
          (_) => SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive)
        );
        Timer(
          transitionDuration,
          () => SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeRight,
            DeviceOrientation.landscapeLeft,
          ])
        );
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
            Future.doWhile(() async {
              int? audioCurrentTrackIndex = await videoController!.getAudioTrack();
              if (audioCurrentTrackIndex == null || audioCurrentTrackIndex < 0) {
                return true;
              }
              videoController!.getAudioTracks().then((aTracks) {
                buildTracksFromVLC(
                  aTracks,
                  audioCurrentTrackIndex,
                  (tracks) => store.dispatch(VideoSetAudioTracksAction(tracks)),
                  (currentTrack) => store.dispatch(SetAudioTrackAction(currentTrack))
                );
              });
              return false;
            });
            Future.doWhile(() async {
              int? subCurrentTrackIndex = await videoController!.getSpuTrack();
              if (subCurrentTrackIndex == null || subCurrentTrackIndex < 0) {
                if (store.state.streamingParams!.currentAudioTrack != null) {
                  return false;
                }
                return true;
              }
              videoController!.getSpuTracks().then((sTracks) {
                buildTracksFromVLC(
                  sTracks,
                  subCurrentTrackIndex,
                  (tracks) => store.dispatch(VideoSetSubtitlesTracksAction(tracks)),
                  (currentTrack) => store.dispatch(SetSubtitlesTrackAction(currentTrack))
                );
              });
              return false;
            });
            store.dispatch(LoadedAction());
          }
        );
      }),
      onDispose: ((store) {
        SystemChrome.setPreferredOrientations(
          DeviceOrientation.values,
        );
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
        positionTimer?.cancel();
        systemBarTimer?.cancel();
        videoController?.dispose().onError((error, stackTrace) {});
        store.dispatch(UnloadVideoAction());
        store.dispatch(UnsetStreamingParametersAction());
      }),
      builder: (context, store) {
        return SafeScaffold(
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
                    key: const Key("Video Controller"),
                    aspectRatio: 16 / 9,
                    controller: videoController!,
                  ),
                  (videoController?.value.position.inMicroseconds ?? 0) > 0
                  ? HideOnTap(
                    child: VideoControls(
                      onMethodSelect: (_) {},
                      onSlide: (position) {
                        videoController!.seekTo(position);
                      },
                      onSubtitleTrackSelect: (newTrack) => videoController!.setSpuTrack(newTrack?.index ?? -1),
                      onAudioTrackSelect: (newTrack) => videoController!.setAudioTrack(newTrack.index),
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
