import 'package:myoo/myoo/src/actions/client_actions.dart';
import 'package:myoo/myoo/src/actions/collection_actions.dart';
import 'package:myoo/myoo/src/actions/library_actions.dart';
import 'package:myoo/myoo/src/actions/loading_actions.dart';
import 'package:myoo/myoo/src/actions/movie_actions.dart';
import 'package:myoo/myoo/src/actions/search_actions.dart';
import 'package:myoo/myoo/src/actions/season_actions.dart';
import 'package:myoo/myoo/src/actions/tv_series_actions.dart';
import 'package:myoo/myoo/src/actions/video_actions.dart';
import 'package:redux/redux.dart';

/// List of reducers for loading State ([bool]) of [AppState]
final loadingReducers = combineReducers<bool>([
  TypedReducer<bool, SearchItems>(toTrue),
  TypedReducer<bool, SearchedItems>(toFalse),
  TypedReducer<bool, LoadingAction>(toTrue),
  TypedReducer<bool, LoadedAction>(toFalse),
  TypedReducer<bool, LoadedMovieAction>(toFalse),
  TypedReducer<bool, LoadedVideoAction>(toFalse),
  TypedReducer<bool, LoadedTVSeriesAction>(toFalse),
  TypedReducer<bool, LoadedCollectionAction>(toFalse),
  TypedReducer<bool, LoadedSeasonAction>(toFalse),
  TypedReducer<bool, LoadStoredClientsAction>(toTrue),
  TypedReducer<bool, LoadMovieAction>(toTrue),
  TypedReducer<bool, LoadVideoAction>(toTrue),
  TypedReducer<bool, LoadTVSeriesAction>(toTrue),
  TypedReducer<bool, LoadCollectionAction>(toTrue),
  TypedReducer<bool, LoadSeasonAction>(toTrue),
  TypedReducer<bool, LoadLibraries>(toTrue),
  TypedReducer<bool, LoadContentFromLibrary>(toTrue),
  TypedReducer<bool, LoadedStoredClientsAction>(toFalse),
  TypedReducer<bool, NoLoadedStoredClientsAction>(toFalse),
  TypedReducer<bool, LibraryIsFullAction>(toFalse),
  TypedReducer<bool, LoadedContentFromLibraryAction>(toFalse)
]);

bool toTrue(_, __) => true;
bool toFalse(_, __) => false;
