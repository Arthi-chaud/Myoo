import 'package:myoo/kyoo_api/src/models/video.dart';
import 'package:myoo/myoo/src/actions/action.dart';

/// Action to set [Video] as [AppState]'s current [Video]
class SetCurrentVideo extends ContainerAction<Video> {
  SetCurrentVideo(Video video) : super(content: video);
}

/// Action to unload [AppState]'s current [Video]
class UnloadVideoAction extends Action {}
