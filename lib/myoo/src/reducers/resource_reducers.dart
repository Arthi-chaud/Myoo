import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/collection.dart';
import 'package:myoo/myoo/src/actions/action.dart';
import 'package:myoo/myoo/src/actions/client_actions.dart';
import 'package:myoo/myoo/src/actions/collection_actions.dart';
import 'package:myoo/myoo/src/actions/movie_actions.dart';
import 'package:myoo/myoo/src/actions/season_actions.dart';
import 'package:myoo/myoo/src/actions/tv_series_actions.dart';
import 'package:myoo/myoo/src/actions/video_actions.dart';
import 'package:redux/redux.dart';

final currentMovieReducers = combineReducers<Movie?>([
  TypedReducer<Movie?, LoadedMovieAction>(setResource<Movie>),
  TypedReducer<Movie?, SetCurrentMovie>(setResource<Movie>),
  TypedReducer<Movie?, UnloadMovieAction>(unsetResource<Movie>),
  TypedReducer<Movie?, UseClientAction>((_, __) => null),
]);

final currentTVSeriesReducers = combineReducers<TVSeries?>([
  TypedReducer<TVSeries?, LoadedTVSeriesAction>(setResource<TVSeries>),
  TypedReducer<TVSeries?, SetCurrentTVSeries>(setResource<TVSeries>),
  TypedReducer<TVSeries?, UnloadTVSeriesAction>(unsetResource<TVSeries>),
  TypedReducer<TVSeries?, UseClientAction>((_, __) => null),
]);

final currentSeasonReducers = combineReducers<Season?>([
  TypedReducer<Season?, LoadedSeasonAction>(setResource<Season>),
  TypedReducer<Season?, UnloadSeasonAction>(unsetResource<Season>),
  TypedReducer<Season?, UseClientAction>((_, __) => null),
]);

final currentVideoReducers = combineReducers<Video?>([
  TypedReducer<Video?, SetCurrentVideo>(setResource<Video>),
  TypedReducer<Video?, UnloadVideoAction>(unsetResource<Video>),
  TypedReducer<Video?, UseClientAction>((_, __) => null),
  
]);

final currentCollectionReducers = combineReducers<Collection?>([
  TypedReducer<Collection?, LoadedCollectionAction>(setResource<Collection>),
  TypedReducer<Collection?, SetCurrentCollection>(setResource<Collection>),
  TypedReducer<Collection?, UnloadCollectionAction>(unsetResource<Collection>),
  TypedReducer<Collection?, UseClientAction>((_, __) => null),
]);

T? setResource<T>(T? oldValue, action) => (action as ContainerAction<T?>).content;
T? unsetResource<T>(T? oldValue, action) => null;
