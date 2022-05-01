import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/track.dart';
import 'package:myoo/myoo/src/actions/action.dart';
import 'package:myoo/myoo/src/actions/client_actions.dart';
import 'package:myoo/myoo/src/actions/streaming_actions.dart';
import 'package:myoo/myoo/src/models/streaming_parameters.dart';
import 'package:redux/redux.dart';

final streamingReducers = combineReducers<StreamingParameters?>([
  TypedReducer<StreamingParameters?, InitStreamingParametersAction>(initStreamingParameters),
  TypedReducer<StreamingParameters?, SetStreamingMethodAction>(setStreamingMethod),
  TypedReducer<StreamingParameters?, PlayAction>(play),
  TypedReducer<StreamingParameters?, PauseAction>(pause),
  TypedReducer<StreamingParameters?, TogglePlayAction>(togglePlay),

  TypedReducer<StreamingParameters?, SetTotalDurationAction>(setTotalDuration),
  TypedReducer<StreamingParameters?, SetCurrentPositionAction>(setCurrentPosition),

  TypedReducer<StreamingParameters?, SetSubtitlesTrackAction>(setSubtitlesTrackAction),

  TypedReducer<StreamingParameters?, UnsetStreamingParametersAction>((_, __) => null),
  TypedReducer<StreamingParameters?, UseClientAction>((_, __) => null),
]);

StreamingParameters initStreamingParameters(StreamingParameters? old, action) => StreamingParameters.init();

StreamingParameters setStreamingMethod(StreamingParameters? old, action) =>
  old!.withParams(method: (action as ContainerAction<StreamingMethod>).content);

StreamingParameters play(StreamingParameters? old, action) =>
  old!.withParams(isPlaying: true);

StreamingParameters pause(StreamingParameters? old, action) =>
  old!.withParams(isPlaying: false);

StreamingParameters togglePlay(StreamingParameters? old, action) =>
  old!.withParams(isPlaying: !(old.isPlaying));

StreamingParameters setTotalDuration(StreamingParameters? old, action) =>
  old!.withParams(totalDuration: (action as ContainerAction<Duration>).content);

StreamingParameters setCurrentPosition(StreamingParameters? old, action) =>
  old!.withParams(currentPosition: (action as ContainerAction<Duration>).content);

StreamingParameters setSubtitlesTracksAction(StreamingParameters? old, action) =>
  old!.withParams(subtitlesTracks: (action as ContainerAction<List<String>>).content);

StreamingParameters setSubtitlesTrackAction(StreamingParameters? old, action) =>
  old!.withParams(currentSubtitlesTrack: (action as ContainerAction<Track?>).content);
