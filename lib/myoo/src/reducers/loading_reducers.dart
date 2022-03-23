import 'package:myoo/myoo/src/actions/client_actions.dart';
import 'package:myoo/myoo/src/actions/collection_actions.dart';
import 'package:myoo/myoo/src/actions/library_actions.dart';
import 'package:myoo/myoo/src/actions/loading_actions.dart';
import 'package:myoo/myoo/src/actions/movie_actions.dart';
import 'package:myoo/myoo/src/actions/season_actions.dart';
import 'package:myoo/myoo/src/actions/tv_series_actions.dart';
import 'package:redux/redux.dart';

/// List of reducers for loading State ([bool]) of [AppState]
final loadingReducers = combineReducers<bool>([
  TypedReducer<bool, LoadedAction>(toFalse),
  TypedReducer<bool, LoadedMovieAction>(toFalse),
  TypedReducer<bool, LoadedTVSeriesAction>(toFalse),
  TypedReducer<bool, LoadedCollectionAction>(toFalse),
  TypedReducer<bool, LoadedSeasonAction>(toFalse),
  TypedReducer<bool, LoadAction>(toTrue),
  TypedReducer<bool, LoadStoredClientsAction>(toTrue),
  TypedReducer<bool, LoadMovieAction>(toTrue),
  TypedReducer<bool, LoadTVSeriesAction>(toTrue),
  TypedReducer<bool, LoadCollectionAction>(toTrue),
  TypedReducer<bool, LoadSeasonAction>(toTrue),
  TypedReducer<bool, LoadLibraries>(toTrue),
  TypedReducer<bool, LoadContentFromLibrary>(toTrue),
]);

bool toTrue(_, __) => true;
bool toFalse(_, __) => false;
