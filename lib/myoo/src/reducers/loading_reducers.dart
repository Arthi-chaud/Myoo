import 'package:myoo/myoo/src/actions/collection_actions.dart';
import 'package:myoo/myoo/src/actions/loading_actions.dart';
import 'package:myoo/myoo/src/actions/movie_actions.dart';
import 'package:myoo/myoo/src/actions/season_actions.dart';
import 'package:myoo/myoo/src/actions/tv_series_actions.dart';
import 'package:redux/redux.dart';

/// List of reducers for loading State ([bool]) of [AppState]
final loadingReducers = combineReducers<bool>([
  TypedReducer<bool, LoadedAction>((_, __) => false),
  TypedReducer<bool, LoadedMovieAction>((_, __) => false),
  TypedReducer<bool, LoadedTVSeriesAction>((_, __) => false),
  TypedReducer<bool, LoadedCollectionAction>((_, __) => false),
  TypedReducer<bool, LoadedSeasonAction>((_, __) => false),
  TypedReducer<bool, LoadAction>((_, __) => true)
]);
