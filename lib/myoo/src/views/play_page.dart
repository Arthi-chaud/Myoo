import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/kyoo_api/src/models/video.dart';
import 'package:myoo/myoo/src/actions/navigation_actions.dart';
import 'package:myoo/myoo/src/actions/video_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/widgets/safe_scaffold.dart';
import 'package:video_player/video_player.dart';

class PlayPage extends StatefulWidget {

  const PlayPage({Key? key}) : super(key: key);

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  late VideoPlayerController videoController;
  late ChewieController chewieController;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      onInit: ((store) async {
        Video currentVideo = store.state.currentVideo!;
        KyooClient currentClient = store.state.currentClient!;

        //store.dispatch(LoadingAction());
        videoController = VideoPlayerController.network(
          currentClient.getStreamingLink(currentVideo.slug, StreamingMethod.transmux)
        );
        //store.dispatch(LoadedAction());
        videoController.initialize();
        videoController.play();
        chewieController = ChewieController(
          videoPlayerController: videoController,
          fullScreenByDefault: true,
          showControlsOnInitialize: false,
          allowPlaybackSpeedChanging: false,
        );
      }),
      onDispose: ((store) {
        videoController.dispose();
        chewieController.dispose();
        store.dispatch(UnloadVideoAction());
      }),
      builder: (context, store) {
        return SafeScaffold(
          bottom: true,
          scaffold: Scaffold(
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.back_hand),
              onPressed: () => store.dispatch(NavigatorPopAction()),
            ),
            body: Center(
              child: Chewie(
                controller: chewieController,
              )
            ),
          ),
        );
      },
    );
  }
}
