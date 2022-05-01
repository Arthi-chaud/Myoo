import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/track.dart';
import 'package:myoo/myoo/src/actions/action.dart';

/// Action to set [AppState]'s current [StreamingParameters] with default values
class InitStreamingParametersAction extends Action {}

/// Action to set streaming method
class SetStreamingMethodAction extends ContainerAction<StreamingMethod> {
  SetStreamingMethodAction(StreamingMethod method) : super(content: method);
}

/// Action to set playing state at true
class PlayAction extends Action {}

/// Action to set playing state to false
class PauseAction extends Action {}

/// Action to toggle playing state
class TogglePlayAction extends Action {}

/// Action to set current play posittion
class SetCurrentPositionAction extends ContainerAction<Duration> {
  SetCurrentPositionAction(Duration position) : super(content: position);
}

/// Action to set total duration
class SetTotalDurationAction extends ContainerAction<Duration> {
  SetTotalDurationAction(Duration position) : super(content: position);
}

/// Action to remove streaming parameters from state
class UnsetStreamingParametersAction extends Action {}

/// Action to select current subtitle track
class SetSubtitlesTrackAction extends ContainerAction<Track?> {
  SetSubtitlesTrackAction(Track? track) : super(content: track);
}
