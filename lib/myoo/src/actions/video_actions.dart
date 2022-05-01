import 'package:myoo/kyoo_api/src/models/slug.dart';
import 'package:myoo/kyoo_api/src/models/track.dart';
import 'package:myoo/kyoo_api/src/models/watch_item.dart';
import 'package:myoo/myoo/src/actions/action.dart';

/// Action to unload [AppState]'s current [Video]
class UnloadVideoAction extends Action {}

/// Action to load [WatchItem] as [AppState]'s current [WatchItem]
class LoadVideoAction extends ContainerAction<Slug> {
  LoadVideoAction(Slug videoSlug) : super(content: videoSlug);
}

/// Action when a [WatchItem] is loaded
class LoadedVideoAction extends ContainerAction<WatchItem> {
  LoadedVideoAction(WatchItem watchItem) : super(content: watchItem);
}

/// Action to set subtitles tracks
class VideoSetSubtitlesTracksAction extends ContainerAction<List<Track>> {
  VideoSetSubtitlesTracksAction(List<Track> subs) : super(content: subs);
}

/// Action to set subtitles tracks
class VideoSetAudioTracksAction extends ContainerAction<List<Track>> {
  VideoSetAudioTracksAction(List<Track> audio) : super(content: audio);
}
