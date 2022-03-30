import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/kyoo_api/src/models/video.dart';
import 'package:myoo/myoo/src/actions/loading_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/widgets/loading_widget.dart';
import 'package:video_player/video_player.dart';

class PlayPage extends StatefulWidget {

  const PlayPage({Key? key}) : super(key: key);

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  late VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      onInit: ((store) {
        Video currentVideo = store.state.currentVideo!;
        KyooClient currentClient = store.state.currentClient!;

        store.dispatch(LoadingAction());
        _controller = VideoPlayerController.network(
          currentClient.getStreamingLink(currentVideo.slug, StreamingMethod.transmux)
        )..initialize().then(
          (_) {
            store.dispatch(LoadedAction());
            _controller.play();
          }
        );
      }),
      builder: (context, store) {
        if (store.state.isLoading) {
          return const LoadingWidget();
        }
        return Scaffold(
          body: Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
        );
      },
    );
  }
}
